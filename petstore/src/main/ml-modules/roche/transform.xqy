xquery version "1.0-ml";
import module namespace pet-json = "http://pets.com/pets-json" at "generate-report.xqy";

declare variable $URI external;

pet-json:report-generation("Rottweiler.xml");

(:xdmp:log("Calling Corb transform on URI: " || $URI):)