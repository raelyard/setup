function script:bootToOsX
{
	& "C:\Program Files\Boot Camp\Bootcamp.exe" -StartupDisk "Macintosh HD"
	restart-computer -force
}
