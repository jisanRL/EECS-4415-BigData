(:
    Report the aggregate gdp per capita (gdppc) for democracies versus non-democracies.
:)

(:~ fix this ~:)
<gdp_per_capita> {
    let $cd := 
    <data>
    {
        let $doc := doc("http://www.eecs.yorku.ca/course/4415/assignment/xquery/dataset/mondial-2015.xml")
        for $ctr in $doc//country
        let $ryr := max($ctr/population/@year)
        let $ppl := $ctr/population[$ryr=@year][1]
        let $govt := 
        if (
        (fn:contains($ctr/government/text(), "democracy") or fn:contains($ctr/government/text(), "republic") or fn:contains($ctr/government/text(), "constitutional monarchy")) and not(fn:contains($ctr/government/text(), "dictator"))) 
        then ("democracy") else ("non-democracy")
        where exists($ctr/gdp_total)
        return <country gdp='{$ctr/gdp_total}' gvt='{$govt}' pop='${$ppl}'></country>
    }
    </data>

    let $td := 
    <data>
    {
        for $ctr in $cd/country
        group by $gd := $ctr/@gvt
        order by $gd
        return <countries government='{$gd}' gdp_total='{sum($ctr/@gdp)}' pop_total="{sum($ctr/@pop)}"></countries>
    }
    </data>
    for $ctr in $td/countries
    let $gdppc := $ctr/@gdp_total div $ctr/@pop_total * 1000000
    return <countries government='{$ctr/@government}' gdppc='${format-number($gdppc, '#,##0.00')}'/>
}
</gdp_per_capita>
