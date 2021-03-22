(:
Report the countries that have “Buddhist” reported as a religion practiced within the country.
:)

<buddhist> {
    for $ctr in doc("http://www.eecs.yorku.ca/course/4415/assignment/xquery/dataset/mondial-2015.xml")/mondial/country[religion/text()="Buddhist"]
    return <country name='{$ctr/name}' percentage='{$ctr/religion[text() = 'Buddhist']/@percentage}'/> 
}
</buddhist>