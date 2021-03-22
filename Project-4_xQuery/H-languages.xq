(:
Generate a document that reports for each language, 
the countries that have a reported population that speaks that language. 
Report in an attribute speakers for <country> an estimate of the number 
of speakers of that language (as country's population times the percentage 
that speak that language).
:)

(:refurbish this :)
<languages> {
    let $doc := doc("http://www.eecs.yorku.ca/course/4415/assignment/xquery/dataset/mondial-2015.xml")
    for $lang in distinct-values($doc//language)
    order by $lang
    
    return <language name='{$lang}'> {
        for $ctr in $doc//country
        let $lst := max($ctr/population/@year)
        let $lsp := $ctr/population[$lst=@year]
        let $spk := round($ctr/language[$lang=text()]/@percentage * 0.01 * $lsp)
        order by xs:integer($spk) descending
        return if ($ctr/language/text()=$lang) then (
            <country name='{$ctr/name}' speakers='{xs:integer($spk)}'/>
        ) else()
    }     
    </language>
}    
</languages>