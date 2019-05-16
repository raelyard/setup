function script:EnsureDirectory
{
  param($path)
  if(!(Test-Path $path -PathType Container))
  {
    New-Item -type directory $path
  }
}

function script:CreateRepository
{
  param($name)
  New-Item -type directory $name
  Push-Location $name
  git init
}

function script:CreateIgnoreFile
{
  EnsureDirectory ~/.raelyard
  try {
    Invoke-WebRequest https://raw.githubusercontent.com/github/gitignore/master/VisualStudio.gitignore -OutFile ~/.raelyard/.gitignore.standard.dotnet
  }
  catch {
    # Swallowing failure and using last downdoaded file in case of not being connected
  }
  Copy-Item ~/.raelyard/.gitignore.standard.dotnet .gitignore
  $gitIgnoreContent = Get-Content .gitignore
  $gitIgnoreContent[$gitIgnoreContent.IndexOf("# tools/**")] = "tools/**"
  $gitIgnoreContent[$gitIgnoreContent.IndexOf("# !tools/packages.config")] = "!tools/packages.config"
  Set-Content .gitignore $gitIgnoreContent
  Commit "added standard template ignore file to reduce noise"
}

function script:CreateReadme
{
  New-Item README.md
  Commit "added a README file to document why this repository exists"
}

function script:CreateSolution
{
  dotnet new sln
  Commit "added a solution file for tooling convenience"
}

function script:Commit
{
  param($message)
  git add .
  git commit -m $message
}

function script:AddProject
{
  param($template, $subdomainName, $topLevelDomainName, $projectName)
  dotnet new $template -n $projectName 
  $assemblyName = "$topLevelDomainName.$name.$projectName"
  $rootNamespace = $assemblyName
  if($rootNamespace.EndsWith(".DomainEvents")) {
    $rootNamespace += ".v0"
  }
  AddProjectFilePropertyGroupElement $projectName/$projectName.csproj "AssemblyName" $assemblyName
  AddProjectFilePropertyGroupElement $projectName/$projectName.csproj "RootNamespace" $rootNamespace
  dotnet sln add $projectName/$projectName.csproj
}

function script:AddDomainEvents
{
  param($name, $topLevelDomainName)
  AddProject classlib $name $topLevelDomainName DomainEvents
  Remove-Item DomainEvents/Class1.cs
  AddProjectFilePropertyGroupElement "DomainEvents/DomainEvents.csproj" "PackageId" " $topLevelDomainName.$name.DomainEvents"
  Commit "Added domain events project to enable publishing events within and beyond this subdomain"
}

function script:AddProjectFilePropertyGroupElement
{
  param($projectFilePath, $newElementName, $newElementValue)
  $projectFile = Resolve-Path "$projectFilePath"
  $projectFileXml = [xml](Get-Content -Path $projectFile)
  $newElement = $projectFileXml.CreateElement($newElementName)
  $newElement.InnerXml = $newElementValue
  $projectFileXml.Project.PropertyGroup.AppendChild($newElement)
  $projectFileXml.Save($projectFile)
}

function script:AddDomain
{
  param($name)
  AddProject classlib $topLevelDomainName $name Domain
  Remove-Item Domain/Class1.cs
  dotnet add Domain/Domain.csproj reference "DomainEvents/DomainEvents.csproj"
  Commit "Added domain project to enable fleshing out the solution"
}

function script:AddProcessor
{
  param($topLevelDomainName, $subdomainName)
  AddProject nsbdockercontainer $name $topLevelDomainName Processor
  Remove-Item Processor/Host.cs
  dotnet add Processor/Processor.csproj package Raelyard.Common.NServiceBus
  dotnet add Processor/Processor.csproj package NServiceBus
  dotnet add Processor/Processor.csproj package NServiceBus.Newtonsoft.Json
  $programClassFile = "Processor/Program.cs"
  $programClassFileContent = Get-Content $programClassFile
  $programClassFileContent[$programClassFileContent.IndexOf("")] = "using Raelyard.Common.NServiceBus;`n"
  $programClassFileContent[$programClassFileContent.IndexOf("namespace Processor")] = "namespace $topLevelDomainName.$subdomainName.Processor"
  Set-Content $programClassFile $programClassFileContent
  dotnet add Processor/Processor.csproj reference "DomainEvents/DomainEvents.csproj"
  dotnet add Processor/Processor.csproj reference Domain/Domain.csproj
  Commit "Added processor project to enable handling commands and events"
}

function script:AddWeb
{
  param($name)
  AddProject mvc $name $topLevelDomainName Web
  dotnet add Web/Web.csproj reference "DomainEvents/DomainEvents.csproj"
  dotnet add Web/Web.csproj reference Domain/Domain.csproj
  Commit "Added web project to enable creating user interface"
}

function script:AddSpecification
{
  param($name)
  AddProject xunit $name $topLevelDomainName Specification
  dotnet remove Specification/Specification.csproj package xunit.runner.visualstudio
  dotnet remove Specification/Specification.csproj package xunit
  Remove-Item Specification/UnitTest1.cs
  dotnet add Specification/Specification.csproj package machine.specifications
  dotnet add Specification/Specification.csproj package Machine.Specifications.Runner.VisualStudio
  dotnet add Specification/Specification.csproj package shouldly
  dotnet add Specification/Specification.csproj reference "DomainEvents/DomainEvents.csproj"
  dotnet add Specification/Specification.csproj reference Domain/Domain.csproj
  if(Test-Path Processor/Processor.csproj)
  {
    dotnet add Specification/Specification.csproj reference Processor/Processor.csproj
  }
  if(Test-Path Web/Web.csproj)
  {
    dotnet add Specification/Specification.csproj reference Web/Web.csproj
  }
  Commit "Added specification project to enable understanding of the business problem"
}

function script:AddTest
{
  param($name, $nunit)

  $template = ChooseTestProjectTemplate $nunit
  AddProject $template $name $topLevelDomainName Test
  Remove-Item Test/UnitTest1.cs
  dotnet add Test/Test.csproj package shouldly
  dotnet add Test/Test.csproj reference "DomainEvents/DomainEvents.csproj"
  dotnet add Test/Test.csproj reference Domain/Domain.csproj
  if(Test-Path Processor/Processor.csproj)
  {
    dotnet add Test/Test.csproj reference Processor/Processor.csproj
  }
  if(Test-Path Web/Web.csproj)
  {
    dotnet add Test/Test.csproj reference Web/Web.csproj
  }
  Commit "Added test project to enable driving design and providing confidence"
}

function script:ChooseTestProjectTemplate
{
  param($nunit)

  $template = "xunit"
  if($nunit)
  {
    $template = "nunit"
  }
  $template
}

function script:AddCakeBuild
{
  EnsureDirectory ~/.raelyard/CakeScripts
  try {
    Invoke-WebRequest https://raw.githubusercontent.com/raelyard/domain-standards/master/build.standard.cake -OutFile ~/.raelyard/CakeScripts/build.cake
    Invoke-WebRequest https://cakebuild.net/download/bootstrapper/windows -OutFile ~/.raelyard/CakeScripts/build.ps1
    Invoke-WebRequest https://cakebuild.net/download/bootstrapper/linux -OutFile ~/.raelyard/CakeScripts/build.sh
  }
  catch {
    # Swallowing failure and using last downdoaded file in case of not being connected
  }
  Copy-Item ~/.raelyard/CakeScripts/build.cake .
  Copy-Item ~/.raelyard/CakeScripts/build.ps1 .
  Copy-Item ~/.raelyard/CakeScripts/build.sh .
  try {
    chmod +x build.sh
  }
  catch {
    # Swallowing chmod does not exist failure on Windows
  }
  Commit "Added Cake Build scripts to enable repeatable build and test on workstation and build server"
}

function script:CreateSourceHostingProject
{
  param($name, $sourceHostingProjectNamespace, $sourceHostingRootDomain="git@gitlab.com")

  echo "${sourceHostingRootDomain}:${sourceHostingProjectNamespace}/${name}.git"
  git push --set-upstream "${sourceHostingRootDomain}:${sourceHostingProjectNamespace}/${name}.git" master
}

function script:NewSubdomain
{
  param([string]$name, [string]$topLevelDomainName, [string]$sourceHostingProjectNamespace, [switch]$noProcessor, [switch]$noWeb, [switch]$noSpec, [switch]$noTest, [switch]$nunit, [switch]$open, [switch]$openVS, [switch]$openRider)

  $ErrorActionPreference = "Stop"
  if(!$name) {
    throw "Name is required"
  }
  if(!$topLevelDomainName) {
    $topLevelDomainName = Get-Location | Split-Path -Leaf
  }

  CreateRepository $name
  CreateIgnoreFile
  CreateReadMe
  CreateSolution
  AddDomainEvents $name $topLevelDomainName
  AddDomain $name $topLevelDomainName
  if(!$noProcessor) { AddProcessor $topLevelDomainName $name }
  if(!$noWeb) { AddWeb $name $topLevelDomainName }
  if(!$noSpec) { AddSpecification $name $topLevelDomainName }
  if(!$noTest) { AddTest $name $nunit $topLevelDomainName }
  AddCakeBuild
  if($sourceHostingProjectNamespace) { CreateSourceHostingProject $name $sourceHostingProjectNamespace }
  if($open) { code . }
  if($openVS) { devenv "$name.sln" }
  if($openRider) { rider64 "$name.sln" }
  Pop-Location
}

function script:NewTopLevelDomain
{
  param([Parameter(Position = 0)][string]$name, [switch]$noProcessor, [switch]$noWeb, [switch]$noSpec, [switch]$noTest, [switch]$nunit, [Parameter(ValueFromRemainingArguments=$true)][string[]]$subdomains)

  if(!$name) {
    throw "Name is required"
  }
  
  Write-Host "Creating new top-levl domain: $name"

  New-Item -type directory $name
  Set-Location $name

  foreach ($subdomain in $subdomains) {
    Write-Host "Identified subdomain: $subdomain"
    NewSubdomain -name $subdomain -topLevelDomainName $name -noProcessor:$noProcessor -noWeb:$noWeb -noSpec:$noSpec -noTest:$noTest -nunit:$nunit
  }
}
