(:
    Report countries that straddle two (or more) continents. Include as content which continents the country occupies.
:)

<straddle>
{
    for $ctr in doc("http://www.eecs.yorku.ca/course/4415/assignment/xquery/dataset/mondial-2015.xml")/mondial/country
    where count($ctr/encompassed) > 1
    return <country name='{$ctr/name}'>
    {
        for $continent in $ctr/encompassed
        return <continent name='{$continent/@continent}'/>
    }
    </country>
}
</straddle>