(:
    For each country, list the countries that border it by name. 
    Place within the bordering <neighbour> a node <length> that contains the length of the shared border.
:)

 (:refurbish this :)

<countries>{
    let $doc := doc("http://www.eecs.yorku.ca/course/4415/assignment/xquery/dataset/mondial-2015.xml")
    for $country in $doc//country
    order by $country/name
    
    return if(exists($country/border)) then (<country name="{$country/name/text()}">
    {
        for $neighbour in $country/border
        let $nc := data($neighbour/@country)
        let $cntrs := $doc//country
        let $nn := $cntrs[$nc=@car_code]/name
        order by $nn
        return <neighbour name='{$nn}'>
            <length>{data($neighbour/@length)}</length>
        </neighbour>
    }</country>)else()
}
</countries>
