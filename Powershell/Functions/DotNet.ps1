function script:CreateRepository
{
  param($name)
  new-item -type directory $name
  cd $name
  git init
}

function script:CreateIgnoreFile
{
  Invoke-WebRequest https://raw.githubusercontent.com/github/gitignore/master/VisualStudio.gitignore -OutFile .gitignore
  Commit "added standard template ignore file to reduce noise"
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
  param($template, $name)
  dotnet new $template -n $name
  dotnet sln add $name/$name.csproj
}

function script:AddDomain
{
  AddProject classlib Domain
  rm Domain\Class1.cs
  Commit("Added domain project to enable fleshing out the solution")
}

function script:AddWeb
{
  AddProject mvc Web
  dotnet add Web\Web.csproj reference Domain\Domain.csproj
  Commit("Added web project to enable creating user interface")
}

function script:AddSpecification
{
  AddProject xunit Specification
  dotnet remove Specification\Specification.csproj package xunit.runner.visualstudio
  dotnet remove Specification\Specification.csproj package xunit
  dotnet add Specification\Specification.csproj package machine.specifications
  dotnet add Specification\Specification.csproj package Machine.Specifications.Runner.VisualStudio
  dotnet add Specification\Specification.csproj package shouldly
  dotnet add Specification\Specification.csproj reference Domain\Domain.csproj
  rm Specification\UnitTest1.cs
  Commit("Added specification project to enable understanding of the business problem")
}

function script:AddTest
{
  param($nunit)

  $template = ChooseTestProjectTemplate $nunit
  AddProject $template Test
  dotnet add Test\Test.csproj package shouldly
  dotnet add Test\Test.csproj reference Domain\Domain.csproj
  rm Test\UnitTest1.cs
  Commit("Added test project to enable driving design and providing confidence")
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

function script:NewProject
{
  param($name, [switch]$noWeb, [switch]$noSpec, [switch]$noTest, [switch]$nunit, [switch]$open, [switch]$openVS, [switch]$openRider)
  CreateRepository $name
  CreateIgnoreFile
  CreateSolution
  AddDomain $name
  if(!$noSpec) { AddSpecification }
  if(!$noTest) { AddTest $nunit }
  if(!$noWeb) { AddWeb }
  if($open) { code . }
  if($openVS) { devenv "$name.sln" }
  if($openRider) { rider64 "$name.sln" }
}
