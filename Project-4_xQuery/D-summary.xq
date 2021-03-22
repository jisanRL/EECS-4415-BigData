(:
    For each country, report its name, capital, population, and size. 
    Report every country; if one of the requested pieces of information for the country is missing, just leave it out.
:)

(:~ refurbish this~:)

<summary> 
{
    let $doc := doc("http://www.eecs.yorku.ca/course/4415/assignment/xquery/dataset/mondial-2015.xml")
    for $country in $doc/mondial/country
    let $cp := $country/@capital
    let $ly := max($country/population/@year)
    let $lp := data($country/population[$ly=@year])
    let $inc := data($country/indep_date)
    order by $country/name
    
    return <country>
        <name>'{$country/name}'</name>
        <capital>'{$country//city[$cp=@id]/name[1]/text()}'</capital>
        <population year='{$ly}'>'{$lp}'</population>
        <size>'{data($country/@area)}'</size>
        {if(exists($inc)) then(
            <inception>'{$inc}'</inception>
        )else()}
    </country>
       
}
</summary>