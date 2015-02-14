param($name)

function script:CreateRepository
{
	param($name)
	new-item -type directory $name
	cd $name
	git init
}

function script:CreateIgnoreFile
{
	copy-item $setupDirectory\SourceControl\TemplateFiles\.gitignore .
	git add .
	git commit -m "added standard template ignore file to reduce noise when trying to view status and commit"
}

function script:CreateSolution
{
	param($name)
	copy-item $setupDirectory\SourceControl\TemplateFiles\Empty.sln ".\$name.sln"
	git add .
	git commit -m "added a visual studio solution for the convenience of grouping the projects to implement the solution and for ease of build and use of visual studio"
	devenv ".\$name.sln"
}

function script:CreateRepositoryWithSolution
{
	param($name)
	CreateRepository $name
	CreateIgnoreFile
	CreateSolution $name
}
