(:
    For each country, report the alpha city for that country; that is, the city in the country with the largest population.
:)

(:refurbish this :)
<alpha>{
    let $alf := 
    <alpha>{
        let $doc := doc("http://www.eecs.yorku.ca/course/4415/assignment/xquery/dataset/mondial-2015.xml")
        for $country in $doc/mondial/country
        order by $country/name
        return <country name='{$country/name/text()}'>
        {
            for $city in $country//city
            let $ly := max($city/population/@year)
            let $lp := $city/population[@year=$ly]
            return if(exists($ly)) then (<city name='{$city/name[1]/text()}' year='{$ly}' pop='{$lp}'></city>) else()
        }
        </country>
    }
    </alpha>

    for $countries in $alf/country
    let $mp := max($countries/city/@pop)
    where exists($mp)

    return <country name='{$countries/@name}'> 
    {
        for $cty in $countries/city[@pop=$mp]
        return<alpha name='{$cty/@name}' population='{xs:integer($mp)}'>
        </alpha>
    }
    </country>
} 
</alpha>