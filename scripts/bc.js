let text = await (await fetch("https://balatromods.miraheze.org/wiki/Ortalab/Jokers")).text()

let items = text.split('<tr>').slice(4)
let lastItem = items[items.length - 1]
items[items.length - 1] = lastItem.split('</tbody>')[0]

items = items.map(item => item.trim().slice(5, -6).trim().split("<td>").map(ii=>ii.split("</td>")[0]))
let conversions = []
for (let item of items) {
    item[0] = item[0].split('">')
    item[0] = item[0][item[0].length-1].split('</a>')[0].trim()
    item[5] = item[5].split('<span class="o">&#160;</span>')
    item[5] = item[5][item[5].length-1].split('</a>')[0].trim()
    //item[5] = item[5].slice(item[0].length+1, -1)
    console.log(item[0], '=', item[5])
    conversions.push([item[0], item[5]])
}
require('fs').rmSync('Ortalab', {
    recursive: true,
    force: true
})
require("child_process").execSync('git clone https://github.com/Eremel/Ortalab')

let val = require('fs').readFileSync('Ortalab/localization/default.lua', 'utf-8')

val = val.split('["Joker"] = {')[1].split(`		},
        ["Loteria"] = {`)[0].split('\n')

let ortaconversion = {}
for (let i = 0; i < val.length; i++) {
    val[i] = val[i].trim()
    if (val[i].startsWith('[\'j_') || val[i].startsWith('[\"j_')) {
        let id = val[i].slice(2).split(' =')[0].slice(0, -2)
        let name = JSON.parse('['+val[i + 1].split(' = ')[1].trim().slice(0, -1)+']')[0]
        console.log(name)
        ortaconversion[name.trim().toLowerCase().replace(' ', '')] = id.trim()
    }
}


let val2 = require('fs').readFileSync('en-us.lua', 'utf-8')

val2 = val2.split('Joker={')[1].split(`        },
        Other={`)[0].split('\n')

let jokerconversion = {}
for (let i = 0; i < val2.length; i++) {
    val2[i] = val2[i].trim()
    if (val2[i].startsWith('j_')) {
        let id = val2[i].split(' =')[0].slice(0, -2)
        let name = JSON.parse('['+val2[i + 1].split('=')[1].trim().slice(0, -1)+']')[0]
        jokerconversion[name.trim().toLowerCase().replace(' ', '')] = id.trim()
    }
}

let finalconversions = 'Tower.ShimmerOrtaConversions = {}\n'
for (let [orta, bala] of conversions) {
    let orta_id = ortaconversion[orta.toLowerCase().replace(' ', '')]
    let bala_id = jokerconversion[bala.toLowerCase().replace(' ', '')]
    finalconversions += `
Tower.ShimmerOrtaConversions[${JSON.stringify(orta_id)}] = ${JSON.stringify(bala_id)}
Tower.ShimmerOrtaConversions[${JSON.stringify(bala_id)}] = ${JSON.stringify(orta_id)}
`
}
require('fs').writeFileSync('../lib/ortashimmer.lua', finalconversions)