xquery version "1.0-ml";
module namespace pet-json = "http://pets.com/pets-json";
import module namespace json="http://marklogic.com/xdmp/json" at "/MarkLogic/json/json.xqy";
import module namespace op="http://marklogic.com/optic" at "/MarkLogic/optic.xqy";

declare function pet-json:report-generation($viewURI)
{
let $results := pet-json:get-pets-result() 
let $pets-map := pet-json:get-pets-map($results[4])
let $pets-json := xdmp:to-json($pets-map)
return xdmp:document-insert("pets.json", $pets-json,<options xmlns="xdmp:document-insert">  
       <collections>{
        <collection>pets</collection>
        }</collections>
    </options>)
};

declare private function pet-json:get-pets-result()
{
(:cts:uris("", "ascending", cts:and-query(cts:collection-query("pets"), "ordered"), (), ()):)
(:cts:uri-match("*.xml", "ascending", cts:and-query(cts:collection-query("pets"), "ordered"), 1.0, ()):)
op:from-view("pets", "pets")
   (:=> op:where(op:eq(op:col("name"), "Rottweiler")):)
   => op:select(("name", "species", "birth"))
   => op:order-by("name", "species", "birth")
   => op:result()
};

declare private function pet-json:get-pets-map($get-pets-result)
{
  (:let $map := map:map()
  let $total := for $uri at $counter in $get-pets-result
    let $doc := fn:doc($uri)
    let $pet-name := $doc/pet/name/text()  
    let $pet-species := $doc/pet/species/text() 
    let $pet-birth := try {  if ($doc/pet/birth/text() castable as xs:date)
                             then   $doc/pet/birth/text()
                             else fn:error(xs:QName("info"), "invalid date format" , "")}       
                             catch($err) {""}
    
    let $pet-map:= map:new((
        map:entry("name",$pet-name),
        map:entry("species",$pet-species),
        map:entry("birth",$pet-birth)
    ))
    return map:put($map, string($counter), $pet-map)
   return $map:)

   let $map := json:object()
   let $doc := <doc>{$get-pets-result}</doc>
   let $_ := for $get-pets-result at $counter in $doc/json:object
   let $pet-name := $get-pets-result/json:entry[@key eq"pets.pets.name"]/json:value/string()
   let $pet-species := $get-pets-result/json:entry[@key eq"pets.pets.species"]/json:value/string()
   let $pet-birth := $get-pets-result/json:entry[@key eq"pets.pets.birth"]/json:value/string()
   
    let $pet-map:= map:new((
        map:entry("name",$pet-name),
        map:entry("species",$pet-species),
        map:entry("birth",$pet-birth)))
 
   return map:put($map, string($counter), $pet-map)
  return $map 
};