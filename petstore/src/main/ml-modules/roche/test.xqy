xquery version "1.0-ml";
xdmp:document-insert("books.xml",
<books xmlns="http://www.marklogic.com/ns/gs-books">
<book bookid="1">
<title>A Quick Path to an Application</title>
<author>
<last>Smith</last>
<first>Jim</first>
</author>
<publisher>Scribblers Press</publisher>
<isbn>1494-3930392-3</isbn>
<abstract>
Test This book describes in detail the power of how
to use XQuery to build powerful web applications
that are built on the MarkLogic Server platform.
</abstract>
</book>
</books>
)