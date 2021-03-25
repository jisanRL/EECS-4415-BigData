(:
    For each country, list the countries that border it by name. 
    Place within the bordering <neighbour> a node <length> that contains the length of the shared border.
:)
<countries>{
    let $dataset := doc("http://www.eecs.yorku.ca/course/4415/assignment/xquery/dataset/mondial-2015.xml")
    for $ctr in $dataset//country
    order by $ctr/name
    
    return if(exists($ctr/border)) then (<country name='{$ctr/name/text()}'>
    {
        for $nbr in $ctr/border
        let $nc := data($nbr/@country)
        let $ctrs := $dataset//country
        let $neighbours := $ctrs[$nc=@car_code]/name
        order by $neighbours
        
        return <neighbour name='{$neighbours}'><length>{data($nbr/@length)}</length></neighbour>
    }</country>)else()
}
</countries>