xquery version "1.0-ml";
module namespace pet-json = "http://pets.com/pets-json";
import module namespace json="http://marklogic.com/xdmp/json" at "/MarkLogic/json/json.xqy";

declare function pet-json:report-generation()
{
let $results := pet-json:get-pets-result()
let $pets-map := pet-json:get-pets-map($results)
let $pets-json := … (konwersja na xml)
return … ( zapis w bazie danych)
};

declare private function pet-json:get-pets-result()
{
cts:uris("", "ascending", cts:and-query(cts:collection-query("pets"), "ordered"), (), ())
};

declare private function pet-json:get-pets-map($get-pets-result)
{
  let $map := map:map()
  let $total := for $uri at $counter in $get-pets-result
    let $doc := fn:doc($uri)
    let $pet-name := $doc/pet/name  
    let $pet-species := $doc/pet/species 
    let $pet-birth := $doc/pet/birth 
    
    let $pet-map:= map:new((
        map:entry("name",$pet-name),
        map:entry("species",$pet-species),
        map:entry("birth",$pet-birth)
    ))
    return map:put($map, string($counter), $pet-map)
   return $map
};