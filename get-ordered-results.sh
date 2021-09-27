#!/bin/bash
list=$(curl https://api.smash.gg/gql/alpha -L -H "Content-Type: application/json" -H "Authorization: Bearer $1" -d '{"query":"query EventEntrants($slug: String!) {\n  tournament(slug: $slug){\n    events {\n\t\t\tsets(\n        page: 1\n        perPage: 100\n        sortType: RECENT\n      ){\n        nodes {\n          displayScore\n          fullRoundText\n          round\n        }\n      }\n    }\n  }\n}","variables":{"slug":"'"$2"'"},"operationName":"EventEntrants"}' 2>/dev/null | jq .data.tournament.events[].sets.nodes)
python3 -c "matches=$list; winners=[]; losers=[]; ordered=[];
for match in matches:
	if match[\"round\"] > 0:
		winners.append(match)
	else:
		losers.append(match)
winners = sorted(winners, key = lambda item: item['round'])
losers = sorted(losers, key = lambda item: -item['round'])
gf = None
gfr = None
if winners[-1]['round'] != winners[-2]['round']:
	gf = winners[-1]
	winners = winners[:-1]
else:
	gf = winners[-1]
	gfr = winners[-2]
	winners = winners[:-2]
for match in winners:
	ordered.append(match['displayScore'])
for match in losers:
	ordered.append(match['displayScore'])
ordered.append(gf['displayScore'])
if gfr is not None:
	ordered.append(gfr['displayScore'])
with open(\"$2.csv\",'w') as f:
	f.write('player1,player2,p1score,p2score\n')
	for result in ordered:
		p = result.split('-')
		p1n = p[0][:-3]
		p1r = p[0][-2:-1]
		p2n = p[1][1:-2]
		p2r = p[1][-1:]
		if p1n.__contains__('|'):
			p1n = p1n[p1n.index('|')+2:]
		if p2n.__contains__('|'):
			p2n = p2n[p2n.index('|')+2:]
		f.write('{},{},{},{}\n'.format(p1n,p2n,p1r,p2r))
"
