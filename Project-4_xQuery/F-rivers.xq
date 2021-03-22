(:
For each river mentioned, report it by name (as an attribute) and 
contain the list of the countries by name that the river runs through.
:)

<rivers>
{
    let $doc := doc("http://www.eecs.yorku.ca/course/4415/assignment/xquery/dataset/mondial-2015.xml")
    for $rvrs in distinct-values($doc//located_at[@watertype='river']/@river)
    let $rvr := replace($rvrs, '^[^-]*-([^-]*).*$', '$1')
    order by $rvr
    
    return <river name="{$rvr}">
	{
		for $ctr in $doc//country
		where $ctr//located_at[$rvrs=@river]
		order by $ctr/name
		return <country name="{$ctr/name}">
		</country>
	}
	</river>
}  
</rivers>
