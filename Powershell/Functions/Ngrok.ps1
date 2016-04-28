function script:ng($subdomain="developeronfire", $port=4000)
{
	ngrok http -subdomain="$subdomain" $port
}
