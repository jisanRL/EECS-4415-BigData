(:
    For each country, report its name, capital, population, and size. 
    Report every country; if one of the requested pieces of information for the country is missing, just leave it out.
:)

<summary> 
{
    let $dataset := doc("http://www.eecs.yorku.ca/course/4415/assignment/xquery/dataset/mondial-2015.xml")
    for $ctr in $dataset/mondial/country
    let $cp := $ctr/@capital
    let $ly := max($ctr/population/@year)
    let $lp := data($ctr/population[$ly=@year])
    let $inc := data($ctr/indep_date)
    order by $ctr/name
    
    return <country name ='{$ctr/name}'>
        <capital>{$ctr//city[$cp=@id]/name[1]/text()}</capital>
        <population year='{$ly}'>{$lp}</population>
        <size>{data($ctr/@area)}</size>
        {if(exists($inc)) 
        then(
            <inception>{$inc}</inception>
        )else()}
    </country>
}
</summary>