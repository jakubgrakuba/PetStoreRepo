xquery version "1.0-ml";

(:
Sample query that returns all URIs.
:)

(:let $uris := cts:uri-match("Rottweiler.xml", "ascending", cts:and-query(cts:collection-query("pets"), "ordered"), 1.0, ())

return (count($uris), $uris)
return $uris:)

let $uris := cts:uris("Rottweiler.xml", "limit=1", (), (), ())

return (count($uris), $uris)