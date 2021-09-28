# smashgg-match-results
Scripts to pull match-by-match results from smash.gg in the order they happened

Usage:
$ sh get-ordered-results apikey tournamentname 
  
Instructions on how to obtain an API key:
https://developer.smash.gg/docs/authentication/
  
You can find the tournament name in the smash.gg URL of the event.

For example, the tournament name for: https://smash.gg/tournament/super-con4-na-biweekly-20 would be "super-con4-na-biweekly-20"
  
Results are written out into a csv named "tournament-name.csv". Each row represents a single match and are listed in the order they happened (this might be helpful for keeping track of player ratings):

Winners Bracket

Losers Bracket

Grand Finals

Credit to Athkore of the SCON4 community
