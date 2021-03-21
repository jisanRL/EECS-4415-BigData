(:
Report the countries that have “Buddhist” reported as a religion practiced within the country.
:)

<buddhist> {
    for $country in doc("mondial.xml")/mondial/country[religion/text()="Buddhist"]          (:fix this, turn into https://:)
    return <country name='{$country/name}' percentage='{$country/religion[text() = 'Buddhist']/@percentage}'/> 
}
</buddhist>