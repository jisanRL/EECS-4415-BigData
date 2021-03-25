(:
    Report for each continent the land area of the continent as size and the number of countries on that continent.
:)

<continents> {
    (:~ helper var ~:)
    let $thisData := 
    <data> 
    {
        let $dataset := doc("http://www.eecs.yorku.ca/course/4415/assignment/xquery/dataset/mondial-2015.xml")
        for $cnts in distinct-values($dataset//encompassed/@continent)
        order by $cnts

        return <continent name='{$cnts}'>
        {
            for $ctr in $dataset//country
            let $ptc := $ctr//encompassed[$cnts=@continent]/@percentage
            order by $ctr/name

            where $ctr/encompassed/@continent=$cnts
            return <country name='{$ctr/name}' size='{xs:integer(round($ctr/@area * $ptc * 0.01))}'></country>
        }
        </continent>
    }
    </data>
    
    for $theContinent in $thisData/continent
    return <continent name="{$theContinent/@name}" size="{xs:integer(sum($theContinent/country/@size))}" countries="{count($theContinent/country)}">
    {
        $theContinent/country
    }
    </continent>
}
</continents>