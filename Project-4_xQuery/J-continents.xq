(:
    Report for each continent the land area of the continent as size and the number of countries on that continent.
:)

<continents> {
    let $thisData := 
    <data> 
    {
        let $doc := doc("http://www.eecs.yorku.ca/course/4415/assignment/xquery/dataset/mondial-2015.xml")
        for $continents in distinct-values($doc//encompassed/@continent)
        order by $continents
        return <continent name='{$continents}'>
        {
            for $country in $doc//country
            let $ptc := $country//encompassed[$continents=@continent]/percentage
            order by $country/name
            where $country/encompassed/@continent=$continents
            return <country name='{$country/name}' size='{xs:integer(round($country/@area * $ptc * 0.01))}'></country>
        }
        </continent>
    }
    </data>
    for $continent in $thisData/continent
    return <continent name='{$continent/@name}' size='{xs:integer(sum($continent/country/@size))}' countries='{count($continent/country)}'>
    {
        $continent/country
    }
    </continent>
}
</continents>
