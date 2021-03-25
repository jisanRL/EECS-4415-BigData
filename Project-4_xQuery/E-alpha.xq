(:
    For each country, report the alpha city for that country; 
    that is, the city in the country with the largest population.
:)

<alpha>{
    (:~ helper var ~:)
    let $eAlpha := 
    <alpha>{
        let $dataset := doc("http://www.eecs.yorku.ca/course/4415/assignment/xquery/dataset/mondial-2015.xml")
        for $ctr in $dataset/mondial/country
        order by $ctr/name

        return <country name='{$ctr/name/text()}'>
        {
            for $theCity in $ctr//city
            let $ly := max($theCity/population/@year)
            let $lp := $theCity/population[@year=$ly]
            return if(exists($ly)) then (<city name='{$theCity/name[1]/text()}' year='{$ly}' pop='{$lp}'></city>) else()
        }
        </country>
    }
    </alpha>

    for $ctrs in $eAlpha/country
    let $mp := max($ctrs/city/@pop)
    where exists($mp)                   

    (:~ final return statement  ~:)
    return <country name='{$ctrs/@name}'> 
    {
        for $cty in $ctrs/city[@pop=$mp]
        return<alpha name='{$cty/@name}' population='{xs:integer($mp)}'>
        </alpha>
    }
    </country>
} 
</alpha>