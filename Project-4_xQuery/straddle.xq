(:
    Report countries that straddle two (or more) continents. Include as content which continents the country occupies.
:)

<straddle>
{
    for $country in doc("mondial.xml")/mondial/country          (:fix this, turn into https://:)
    where count($country/encompassed) > 1
    return <country name='{$country/name}'>
    {
        for $continent in $country/encompassed
        return <continent name='{$continent/@continent}'/>
    }
    </country>
}
</straddle>