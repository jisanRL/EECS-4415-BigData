(:
Generate a document that reports for each language, 
the countries that have a reported population that speaks that language. 
Report in an attribute speakers for <country> an estimate of the number 
of speakers of that language (as country's population times the percentage 
that speak that language).
:)

(:refurbish this :)
<languages> {
    let $doc := doc("mondial.xml")
    for $languages in distinct-values($doc//language)
    order by $languages
    
    return <language name='{$languages}'> {
        for $country in $doc//country
        let $lst := max($country/population/@year)
        let $lsp := $country/population[$lst=@year]
        let $spk := round($country/language[$languages=text()]/@percentage * 0.01 * $lsp)
        order by xs:integer($spk) descending
        return if ($country/language/text()=$languages) then (
            <country name='{$country/name}' speakers='{xs:integer($spk)}'/>
        ) else()
    }     
    </language>
}    
</languages>