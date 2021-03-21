(:
    Report countries that have more than 5% inflation and 10% unemployment.
:)

<woe>{
    for $country in doc("mondial.xml")/mondial/country
    where data($country/inflation) > 5 and data($country/unemployment) > 10
    
    return <country inflation='{$country/name}' unemployment='{$country/unemployment}'>
        <inflation>{data($country/inflation)}</inflation>
        <unemployment>{data($country/unemployment)}</unemployment>
    </country> 
}
</woe>
