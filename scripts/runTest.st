| path stream repoPath unitTests numberOfPassed |
"We create a file that will contain the result of the test execution"
path := '/tmp/result.txt'.
path asFileReference exists ifTrue: [ path asFileReference delete ].
stream := path asFileReference writeStream.

Stdio stdout << '>>> Adding $GITHUB_WORKSPACE directory to Iceberg: '.
repoPath := Smalltalk os environment
	at: 'GITHUB_WORKSPACE'
	ifAbsent: [ Stdio stdout nextPutAll: 'NOT DEFINED, WRONG'; crlf. ^ self ].
Stdio stdout << repoPath; lf.
"We load the application software analyzer"
(IceRepositoryCreator new
	location: repoPath asFileReference;
	createRepository) register.
  
"[ Metacello new
	baseline: 'BaselineMap';
	repository: repository;
	load ] on: MCMergeOrLoadWarning do: [ :warning | warning load ]."

"We identify the unit tests contained in the loaded application"
unitTests := (TestCase withAllSubclasses
	select: [ :cls | cls package packageName beginsWith: 'BaselineMap' ]) 
	sorted: [ :c1 :c2 | c1 name < c2 name ].

numberOfPassed := 0.
"We run the unit tests"
unitTests do: [ :unitTestClass | | res |
	res := unitTestClass buildSuite run.
	(res hasFailures or: [ res hasErrors ]) ifTrue: [

		stream
			nextPutAll: 'ERROR: ';
			nextPutAll: unitTestClass name; space;
			nextPutAll: res asString;
			crlf.
		unitTestClass name = #RSExamplesTest ifTrue: [
			[RSExamplesTest new testExamples]
			on: Error
			do: [ :ex | ex signalContext shortDebugStackOn: stream ].
			stream nextPutAll: '-:V-';crlf.
		]
	].
	numberOfPassed := numberOfPassed + res passed size.
].

stream crlf.
stream nextPutAll: 'NUMBER OF UNIT TESTS=', unitTests size asString; crlf.
stream nextPutAll: 'NUMBER OF PASSED TEST METHODS=', numberOfPassed asString; crlf.
stream nextPutAll: 'NUMBER OF TEST METHODS=', (unitTests flatCollect: [ :cls | cls buildSuite tests ]) size asString; crlf.
stream nextPutAll: 'END'; crlf.

"We close the stream and quit Pharo"
stream close.

SmalltalkImage current quitPrimitive
