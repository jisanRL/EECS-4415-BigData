(:
    Report countries that have more than 5% inflation and 10% unemployment.
:)

<woe>{
    for $ctr in doc("http://www.eecs.yorku.ca/course/4415/assignment/xquery/dataset/mondial-2015.xml")/mondial/country
    where data($ctr/inflation) > 5 and data($ctr/unemployment) > 10
    
    return <country inflation='{$ctr/name}' unemployment='{$ctr/unemployment}'>
        <inflation>{data($ctr/inflation)}</inflation>
        <unemployment>{data($ctr/unemployment)}</unemployment>
    </country> 
}
</woe>