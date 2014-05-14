function script:hgLog{thg log}
function script:hgPullAndUpdate{hg pull -u --rebase}
function script:hgPush
{
	hgPullAndUpdate
	hg push --new-branch
}
function script:hgCommit{thg commit}
function script:hgCloseBranch($comment)
{
	$branch = hg branch
	if($branch -eq "default")
	{
		Write-Host "abort: Do not close default branch"
		return "default"
	}
	Write-Host "attempting to close branch $branch"
	if($comment -eq $Null)
	{
		$comment = $branch
		$comment = "Closing branch " + $comment
	}
	Write-Host "hg commit --close-branch -m $comment"
	hg commit --close-branch -m $comment
	Write-Host $branch
	return $branch
}
function script:hgCloseBranchAndMerge($comment)
{
	$branch = hgCloseBranch($comment)
	if($branch -eq "default")
	{
		return
	}
	Write-Host "attempting to merge branch $branch"
	Write-Host "updating to default"
	hg up default
	Write-Host "merging $branch into default"
	hg merge $branch
	Write-Host "committing merge"
	hg commit -m "Merged branch $branch into default"
}
function script:merge($branchToMergeFrom)
{
	if(!$branchToMergeFrom)
	{
		$branchToMergeFrom = "default"
	}
	$branch = hg branch
	Write-Host "merging $branchToMergeFrom into $branch"
	hg merge $branchToMergeFrom
	Write-Host "committing merge"
	hg commit -m "Merged branch $branchToMergeFrom into $branch"
}
function script:hgCommit{thg commit}
