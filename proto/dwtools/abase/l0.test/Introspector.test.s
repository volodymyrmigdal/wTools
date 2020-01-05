( function _Introspector_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../Layer2.s' );
  _.include( 'wTesting' );
}

let _ = _global_.wTools;
let fileProvider = _testerGlobal_.wTools.fileProvider;
let path = fileProvider.path;

// --
// context
// --

function onSuiteBegin()
{
  let self = this;

  self.suiteTempPath = path.pathDirTempOpen( path.join( __dirname, '../..'  ), 'err' );
  self.assetsOriginalSuitePath = path.join( __dirname, '_asset' );

}

//

function onSuiteEnd()
{
  let self = this;
  _.assert( _.strHas( self.suiteTempPath, '/err-' ) )
  path.pathDirTempClose( self.suiteTempPath );
}

// --
// tests
// --

function locationFromStackFrame( test )
{

  var stackCall = 'at Object.stackBasic (C:\\dir\\Introspector.test.s:48:79)';
  test.case = stackCall;
  var exp =
  {
    'original' : 'at Object.stackBasic (C:\\dir\\Introspector.test.s:48:79)',
    'filePath' : '/C/dir/Introspector.test.s',
    'routineName' : 'Object.stackBasic',
    'routineAlias' : null,
    'internal' : 0,
    'line' : 48,
    'col' : 79,
    'filePathLineCol' : '/C/dir/Introspector.test.s:48:79',
    'routineFilePathLineCol' : 'Object.stackBasic @ /C/dir/Introspector.test.s:48:79',
    'fileName' : 'Introspector.test.s',
    'fileNameLineCol' : 'Introspector.test.s:48:79',
  }
  var got = _.introspector.locationFromStackFrame( stackCall );
  test.identical( got, exp );

  /**/

  var stackCall = 'at Object.stackBasic (/C/dir/Introspector.test.s:48:79)';
  test.case = stackCall;
  var exp =
  {
    'original' : 'at Object.stackBasic (/C/dir/Introspector.test.s:48:79)',
    'filePath' : '/C/dir/Introspector.test.s',
    'routineName' : 'Object.stackBasic',
    'routineAlias' : null,
    'internal' : 0,
    'line' : 48,
    'col' : 79,
    'filePathLineCol' : '/C/dir/Introspector.test.s:48:79',
    'routineFilePathLineCol' : 'Object.stackBasic @ /C/dir/Introspector.test.s:48:79',
    'fileName' : 'Introspector.test.s',
    'fileNameLineCol' : 'Introspector.test.s:48:79',
  }
  var got = _.introspector.locationFromStackFrame( stackCall );
  test.identical( got, exp );

  /**/

  var stackCall = 'at iteration (/C/dir/File.js:5:47)';
  test.case = stackCall;
  var exp =
  {
    'original' : 'at iteration (/C/dir/File.js:5:47)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'iteration',
    'routineAlias' : null,
    'internal' : 0,
    'line' : 5,
    'col' : 47,
    'filePathLineCol' : '/C/dir/File.js:5:47',
    'routineFilePathLineCol' : 'iteration @ /C/dir/File.js:5:47',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:47'
  }
  var got = _.introspector.locationFromStackFrame( stackCall );
  test.identical( got, exp );

  /**/

  var stackCall = 'at iteration (C:\\dir\\File.js:5:47)';
  test.case = stackCall;
  var exp =
  {
    'original' : 'at iteration (C:\\dir\\File.js:5:47)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'iteration',
    'routineAlias' : null,
    'internal' : 0,
    'line' : 5,
    'col' : 47,
    'filePathLineCol' : '/C/dir/File.js:5:47',
    'routineFilePathLineCol' : 'iteration @ /C/dir/File.js:5:47',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:47'
  }
  /* xxx2 : problem in _.toStr( 'some\\path' )! */
  var got = _.introspector.locationFromStackFrame( stackCall );
  test.identical( got, exp );

  /**/

  var stackCall = 'at _iteration (C:\\dir\\File.js:5:47)';
  test.case = stackCall;
  var exp =
  {
    'original' : 'at _iteration (C:\\dir\\File.js:5:47)',
    'filePath' : '/C/dir/File.js',
    'routineName' : '_iteration',
    'routineAlias' : null,
    'internal' : 1,
    'line' : 5,
    'col' : 47,
    'filePathLineCol' : '/C/dir/File.js:5:47',
    'routineFilePathLineCol' : '_iteration @ /C/dir/File.js:5:47',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:47',
  }
  var got = _.introspector.locationFromStackFrame( stackCall );
  test.identical( got, exp );

  /**/

  var stackCall = 'at __iteration (C:\\dir\\File.js:5:47)';
  test.case = stackCall;
  var exp =
  {
    'original' : 'at __iteration (C:\\dir\\File.js:5:47)',
    'filePath' : '/C/dir/File.js',
    'routineName' : '__iteration',
    'routineAlias' : null,
    'internal' : 2,
    'line' : 5,
    'col' : 47,
    'filePathLineCol' : '/C/dir/File.js:5:47',
    'routineFilePathLineCol' : '__iteration @ /C/dir/File.js:5:47',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:47',
  }
  var got = _.introspector.locationFromStackFrame( stackCall );
  test.identical( got, exp );

  /**/

  var stackCall = 'at wConsequence.handle_Now (C:\\dir\\File.js:5:15)';
  test.case = stackCall;
  var exp =
  {
    'original' : 'at wConsequence.handle_Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.handle_Now',
    'routineAlias' : null,
    'internal' : 0,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence.handle_Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  }
  var got = _.introspector.locationFromStackFrame( stackCall );
  test.identical( got, exp );

  /**/

  var stackCall = 'at wConsequence._handle_Now (C:\\dir\\File.js:5:15)';
  test.case = stackCall;
  var exp =
  {
    'original' : 'at wConsequence._handle_Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence._handle_Now',
    'routineAlias' : null,
    'internal' : 1,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence._handle_Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  }
  var got = _.introspector.locationFromStackFrame( stackCall );
  test.identical( got, exp );

  /**/

  var stackCall = 'at wConsequence.__handle_Now (C:\\dir\\File.js:5:15)';
  test.case = stackCall;
  var exp =
  {
    'original' : 'at wConsequence.__handle_Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.__handle_Now',
    'routineAlias' : null,
    'internal' : 2,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence.__handle_Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  }
  var got = _.introspector.locationFromStackFrame( stackCall );
  test.identical( got, exp );

  /**/

  var stackCall = 'at wConsequence.handle__Now (C:\\dir\\File.js:5:15)';
  test.case = stackCall;
  var exp =
  {
    'original' : 'at wConsequence.handle__Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.handle__Now',
    'routineAlias' : null,
    'internal' : 0,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence.handle__Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  }
  var got = _.introspector.locationFromStackFrame( stackCall );
  test.identical( got, exp );

  /**/

  var stackCall = 'at wConsequence._handle__Now (C:\\dir\\File.js:5:15)';
  test.case = stackCall;
  var exp =
  {
    'original' : 'at wConsequence._handle__Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence._handle__Now',
    'routineAlias' : null,
    'internal' : 1,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence._handle__Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  }
  var got = _.introspector.locationFromStackFrame( stackCall );
  test.identical( got, exp );

  /**/

  var stackCall = 'at wConsequence.__handle__Now (C:\\dir\\File.js:5:15)';
  test.case = stackCall;
  var exp =
  {
    'original' : 'at wConsequence.__handle__Now (C:\\dir\\File.js:5:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.__handle__Now',
    'routineAlias' : null,
    'internal' : 2,
    'line' : 5,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:5:15',
    'routineFilePathLineCol' : 'wConsequence.__handle__Now @ /C/dir/File.js:5:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:5:15',
  }
  var got = _.introspector.locationFromStackFrame( stackCall );
  test.identical( got, exp );

  /**/

  var stackCall = 'at wConsequence.<anonymous> (C:\\dir\\File.js:9:15)';
  test.case = stackCall;
  var exp =
  {
    'original' : 'at wConsequence.<anonymous> (C:\\dir\\File.js:9:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.{-anonymous-}',
    'routineAlias' : null,
    'internal' : 0,
    'line' : 9,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:9:15',
    'routineFilePathLineCol' : 'wConsequence.{-anonymous-} @ /C/dir/File.js:9:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:9:15',
  }
  var got = _.introspector.locationFromStackFrame( stackCall );
  test.identical( got, exp );

  /**/

  var stackCall = 'at wConsequence.<anonymous>.<anonymous> (/C/dir/File.js:9:15)';
  test.case = stackCall;
  var exp =
  {
    'original' : 'at wConsequence.<anonymous>.<anonymous> (/C/dir/File.js:9:15)',
    'filePath' : '/C/dir/File.js',
    'routineName' : 'wConsequence.{-anonymous-}.{-anonymous-}',
    'routineAlias' : null,
    'internal' : 0,
    'line' : 9,
    'col' : 15,
    'filePathLineCol' : '/C/dir/File.js:9:15',
    'routineFilePathLineCol' : 'wConsequence.{-anonymous-}.{-anonymous-} @ /C/dir/File.js:9:15',
    'fileName' : 'File.js',
    'fileNameLineCol' : 'File.js:9:15',
  }
  var got = _.introspector.locationFromStackFrame( stackCall );
  test.identical( got, exp );

  /**/

  var stackCall = 'at Object.time [as _time] (C:\\dir\\Procedure.s:1503:20)';
  test.case = stackCall;
  var exp =
  {
    'original' : 'at Object.time [as _time] (C:\\dir\\Procedure.s:1503:20)',
    'filePath' : '/C/dir/Procedure.s',
    'routineName' : 'Object.time',
    'routineAlias' : '_time',
    'internal' : 1,
    'line' : 1503,
    'col' : 20,
    'filePathLineCol' : '/C/dir/Procedure.s:1503:20',
    'routineFilePathLineCol' : 'Object.time @ /C/dir/Procedure.s:1503:20',
    'fileName' : 'Procedure.s',
    'fileNameLineCol' : 'Procedure.s:1503:20',
  }
  var got = _.introspector.locationFromStackFrame( stackCall );
  test.identical( got, exp );

  /**/

  var stackCall = 'at Object.time [as __time] (C:\\dir\\Procedure.s:1503:20)';
  test.case = stackCall;
  var exp =
  {
    'original' : 'at Object.time [as __time] (C:\\dir\\Procedure.s:1503:20)',
    'filePath' : '/C/dir/Procedure.s',
    'routineName' : 'Object.time',
    'routineAlias' : '__time',
    'internal' : 2,
    'line' : 1503,
    'col' : 20,
    'filePathLineCol' : '/C/dir/Procedure.s:1503:20',
    'routineFilePathLineCol' : 'Object.time @ /C/dir/Procedure.s:1503:20',
    'fileName' : 'Procedure.s',
    'fileNameLineCol' : 'Procedure.s:1503:20',
  }
  var got = _.introspector.locationFromStackFrame( stackCall );
  test.identical( got, exp );

  /**/

  var stackCall = 'at Object.__time [as _time] (C:\\dir\\Procedure.s:1503:20)';
  test.case = stackCall;
  var exp =
  {
    'original' : 'at Object.__time [as _time] (C:\\dir\\Procedure.s:1503:20)',
    'filePath' : '/C/dir/Procedure.s',
    'routineName' : 'Object.__time',
    'routineAlias' : '_time',
    'internal' : 2,
    'line' : 1503,
    'col' : 20,
    'filePathLineCol' : '/C/dir/Procedure.s:1503:20',
    'routineFilePathLineCol' : 'Object.__time @ /C/dir/Procedure.s:1503:20',
    'fileName' : 'Procedure.s',
    'fileNameLineCol' : 'Procedure.s:1503:20',
  }
  var got = _.introspector.locationFromStackFrame( stackCall );
  test.identical( got, exp );

  /**/

  var stackCall = 'at listOnTimeout (internal/timers.js:531:17)';
  test.case = stackCall;
  var exp =
  {
    'original' : 'at listOnTimeout (internal/timers.js:531:17)',
    'filePath' : 'internal/timers.js',
    'routineName' : 'listOnTimeout',
    'routineAlias' : null,
    'internal' : 2,
    'line' : 531,
    'col' : 17,
    'filePathLineCol' : 'internal/timers.js:531:17',
    'routineFilePathLineCol' : 'listOnTimeout @ internal/timers.js:531:17',
    'fileName' : 'timers.js',
    'fileNameLineCol' : 'timers.js:531:17',
  }
  var got = _.introspector.locationFromStackFrame( stackCall );
  test.identical( got, exp );

  /**/

  var stackCall = 'at eval (<anonymous>:1:16)';
  test.case = stackCall;
  var exp =
  {
    'original' : 'at eval (<anonymous>:1:16)',
    'filePath' : '<anonymous>',
    'routineName' : 'eval',
    'routineAlias' : null,
    'internal' : 0,
    'line' : 1,
    'col' : 16,
    'filePathLineCol' : '<anonymous>:1:16',
    'routineFilePathLineCol' : 'eval @ <anonymous>:1:16',
    'fileName' : '<anonymous>',
    'fileNameLineCol' : '<anonymous>:1:16',
  }
  var got = _.introspector.locationFromStackFrame( stackCall );
  test.identical( got, exp );

  /**/

  var stackCall = 'at eval (eval at program2 (C:\\basic\\program2.js:13:5), <anonymous>:1:16)';
  test.case = stackCall;
  var exp =
  {
    'original' : 'at eval (eval at program2 (C:\\basic\\program2.js:13:5), <anonymous>:1:16)',
    'filePath' : '/C/basic/program2.js',
    'routineName' : 'program2',
    'routineAlias' : null,
    'internal' : 0,
    'line' : 13,
    'col' : 5,
    'filePathLineCol' : '/C/basic/program2.js:13:5',
    'routineFilePathLineCol' : 'program2 @ /C/basic/program2.js:13:5',
    'fileName' : 'program2.js',
    'fileNameLineCol' : 'program2.js:13:5',
  }
  var got = _.introspector.locationFromStackFrame( stackCall );
  test.identical( got, exp );

  /**/

  var stackCall = 'at eval (eval at program2 (/C/basic/program2.js:13:5), <anonymous>:1:16)';
  test.case = stackCall;
  var exp =
  {
    'original' : 'at eval (eval at program2 (/C/basic/program2.js:13:5), <anonymous>:1:16)',
    'filePath' : '/C/basic/program2.js',
    'routineName' : 'program2',
    'routineAlias' : null,
    'internal' : 0,
    'line' : 13,
    'col' : 5,
    'filePathLineCol' : '/C/basic/program2.js:13:5',
    'routineFilePathLineCol' : 'program2 @ /C/basic/program2.js:13:5',
    'fileName' : 'program2.js',
    'fileNameLineCol' : 'program2.js:13:5',
  }
  var got = _.introspector.locationFromStackFrame( stackCall );
  test.identical( got, exp );
}

//

function stackBasic( test )
{

  /* - */

  test.case = 'trivial';
  var expectedTrace = [ 'function3', 'function2', 'function1', _.introspector.location().routineName ];
  var got = function1();
  got = got.split( '\n' );
  expectedTrace.forEach( function( expectedStr, i )
  {
    var expectedRegexp = new RegExp( expectedStr );
    test.description = expectedStr;
    test.identical( expectedRegexp.test( got[ i ] ), true );
  });

  /* - */

  function function1( )
  {
    return function2( );
  }

  function function2( )
  {
    return function3( );
  }

  function function3( )
  {
    debugger;
    return _.introspector.stack();
  }

}

//

function stack( test )
{
  test.case = 'stack is map, range - undefined';
  var got = _.introspector.stack( { notError : 1 }, undefined );
  test.identical( got, undefined );

  test.case = 'stack is Set, range - undefined';
  var got = _.introspector.stack( new Set( [ 1, 2, 3 ] ), undefined );
  test.identical( got, undefined );

  test.case = 'stack - empty string, range - undefined';
  var got = _.introspector.stack( '', undefined );
  test.identical( got, '' );

  test.case = 'stack - empty array, range - undefined';
  var got = _.introspector.stack( [], undefined );
  test.identical( got, '' );

  /* - */

  test.open( 'stack - string, first line - has not "at" or "@"' );

  test.case = 'only stack';
  var got = _.introspector.stack( 'some\nat@\nb\nc\nd' );
  test.identical( got, 'at@\nb\nc\nd' );

  test.case = 'range - undefined';
  var got = _.introspector.stack( 'some\nat@\nb\nc\nd', undefined );
  test.identical( got, 'at@\nb\nc\nd' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] > last index';
  var got = _.introspector.stack( 'some\nat@\nb\nc\nd', [ 0, 5 ] );
  test.identical( got, 'at@\nb\nc\nd' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] === last index';
  var got = _.introspector.stack( 'some\nat@\nb\nc\nd', [ 0, 3 ] );
  test.identical( got, 'at@\nb\nc' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] < last index';
  var got = _.introspector.stack( 'some\nat@\nb\nc\nd', [ 0, 1 ] );
  test.identical( got, 'at@' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] < 0';
  var got = _.introspector.stack( 'some\nat@\nb\nc\nd', [ 0, -1 ] );
  test.identical( got, 'at@\nb\nc\nd' );

  test.case = 'range[ 0 ] - -3, range[ 1 ] > last index';
  var got = _.introspector.stack( 'some\nat@\nb\nc\nd', [ -3, 4 ] );
  test.identical( got, 'b\nc\nd' );

  test.case = 'range[ 0 ] - -3, range[ 1 ] === last index';
  var got = _.introspector.stack( 'some\nat@\nb\nc\nd', [ -3, 3 ] );
  test.identical( got, 'b\nc' );

  test.case = 'range[ 0 ] - -3, range[ 1 ] < last index';
  var got = _.introspector.stack( 'some\nat@\nb\nc\nd', [ -3, 1 ] );
  test.identical( got, '' );

  test.case = 'range[ 0 ] - -3, range[ 1 ] < 0';
  var got = _.introspector.stack( 'some\nat@\nb\nc\nd', [ -3, -1 ] );
  test.identical( got, 'b\nc\nd' );

  test.case = 'range[ 0 ] - 2, range[ 1 ] > last index';
  var got = _.introspector.stack( 'some\nat@\nb\nc\nd', [ 2, 4 ] );
  test.identical( got, 'c\nd' );

  test.case = 'range[ 0 ] - 2, range[ 1 ] === last index';
  var got = _.introspector.stack( 'some\nat@\nb\nc\nd', [ 2, 3 ] );
  test.identical( got, 'c' );

  test.case = 'range[ 0 ] - 2, range[ 1 ] < last index';
  var got = _.introspector.stack( 'some\nat@\nb\nc\nd', [ 2, 1 ] );
  test.identical( got, '' );

  test.case = 'range[ 0 ] - 2, range[ 1 ] < 0';
  var got = _.introspector.stack( 'some\nat@\nb\nc\nd', [ 2, -1 ] );
  test.identical( got, 'c\nd' );

  test.close( 'stack - string, first line - has not "at" or "@"' );

  /* - */

  test.open( 'stack - string, first line - has "at " or "@"' );

  test.case = 'only stack';
  var got = _.introspector.stack( 'at \nb\nc\nd\n \t' );
  test.identical( got, 'at\nb\nc\nd' );

  test.case = 'range - undefined';
  var got = _.introspector.stack( 'at \nb\nc\nd\n \t', undefined );
  test.identical( got, 'at\nb\nc\nd' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] > last index';
  var got = _.introspector.stack( 'at \nb\nc\nd\n \t', [ 0, 5 ] );
  test.identical( got, 'at\nb\nc\nd' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] === last index';
  var got = _.introspector.stack( 'at \nb\nc\nd\n \t', [ 0, 3 ] );
  test.identical( got, 'at\nb\nc' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] < last index';
  var got = _.introspector.stack( 'at \nb\nc\nd\n \t', [ 0, 1 ] );
  test.identical( got, 'at' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] < 0';
  var got = _.introspector.stack( 'at \nb\nc\nd\n \t', [ 0, -1 ] );
  test.identical( got, 'at\nb\nc\nd' );

  test.case = 'range[ 0 ] - -3, range[ 1 ] > last index';
  var got = _.introspector.stack( 'at \nb\nc\nd\n \t', [ -3, 4 ] );
  test.identical( got, 'b\nc\nd' );

  test.case = 'range[ 0 ] - -3, range[ 1 ] === last index';
  var got = _.introspector.stack( 'at \nb\nc\nd\n \t', [ -3, 3 ] );
  test.identical( got, 'b\nc' );

  test.case = 'range[ 0 ] - -3, range[ 1 ] < last index';
  var got = _.introspector.stack( 'at \nb\nc\nd\n \t', [ -3, 1 ] );
  test.identical( got, '' );

  test.case = 'range[ 0 ] - -3, range[ 1 ] < 0';
  var got = _.introspector.stack( 'at \nb\nc\nd\n \t', [ -3, -1 ] );
  test.identical( got, 'b\nc\nd' );

  test.case = 'range[ 0 ] - 2, range[ 1 ] > last index';
  var got = _.introspector.stack( 'at \nb\nc\nd\n \t', [ 2, 4 ] );
  test.identical( got, 'c\nd' );

  test.case = 'range[ 0 ] - 2, range[ 1 ] === last index';
  var got = _.introspector.stack( 'at \nb\nc\nd\n \t', [ 2, 3 ] );
  test.identical( got, 'c' );

  test.case = 'range[ 0 ] - 2, range[ 1 ] < last index';
  var got = _.introspector.stack( 'at \nb\nc\nd\n \t', [ 2, 1 ] );
  test.identical( got, '' );

  test.case = 'range[ 0 ] - 2, range[ 1 ] < 0';
  var got = _.introspector.stack( 'at \nb\nc\nd\n \t', [ 2, -1 ] );
  test.identical( got, 'c\nd' );

  /* */

  test.case = 'only stack';
  var got = _.introspector.stack( '@\nb\nc\nd\n \t' );
  test.identical( got, '@\nb\nc\nd' );

  test.case = 'range - undefined';
  var got = _.introspector.stack( '@\nb\nc\nd\n \t', undefined );
  test.identical( got, '@\nb\nc\nd' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] > last index';
  var got = _.introspector.stack( '@\nb\nc\nd\n \t', [ 0, 5 ] );
  test.identical( got, '@\nb\nc\nd' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] === last index';
  var got = _.introspector.stack( '@\nb\nc\nd\n \t', [ 0, 3 ] );
  test.identical( got, '@\nb\nc' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] < last index';
  var got = _.introspector.stack( '@\nb\nc\nd\n \t', [ 0, 1 ] );
  test.identical( got, '@' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] < 0';
  var got = _.introspector.stack( '@\nb\nc\nd\n \t', [ 0, -1 ] );
  test.identical( got, '@\nb\nc\nd' );

  test.case = 'range[ 0 ] - -3, range[ 1 ] > last index';
  var got = _.introspector.stack( '@\nb\nc\nd\n \t', [ -3, 4 ] );
  test.identical( got, 'b\nc\nd' );

  test.case = 'range[ 0 ] - -3, range[ 1 ] === last index';
  var got = _.introspector.stack( '@\nb\nc\nd\n \t', [ -3, 3 ] );
  test.identical( got, 'b\nc' );

  test.case = 'range[ 0 ] - -3, range[ 1 ] < last index';
  var got = _.introspector.stack( '@\nb\nc\nd\n \t', [ -3, 1 ] );
  test.identical( got, '' );

  test.case = 'range[ 0 ] - -3, range[ 1 ] < 0';
  var got = _.introspector.stack( '@\nb\nc\nd\n \t', [ -3, -1 ] );
  test.identical( got, 'b\nc\nd' );

  test.case = 'range[ 0 ] - 2, range[ 1 ] > last index';
  var got = _.introspector.stack( '@\nb\nc\nd\n \t', [ 2, 4 ] );
  test.identical( got, 'c\nd' );

  test.case = 'range[ 0 ] - 2, range[ 1 ] === last index';
  var got = _.introspector.stack( '@\nb\nc\nd\n \t', [ 2, 3 ] );
  test.identical( got, 'c' );

  test.case = 'range[ 0 ] - 2, range[ 1 ] < last index';
  var got = _.introspector.stack( '@\nb\nc\nd\n \t', [ 2, 1 ] );
  test.identical( got, '' );

  test.case = 'range[ 0 ] - 2, range[ 1 ] < 0';
  var got = _.introspector.stack( '@\nb\nc\nd\n \t', [ 2, -1 ] );
  test.identical( got, 'c\nd' );

  test.close( 'stack - string, first line - has "at " or "@"' );

  /* - */

  test.open( 'stack - array, first element - has not "at" or "@"' );

  test.case = 'range - undefined';
  var got = _.introspector.stack( [ '(vm.js: 12', '(module.js:', '(internal/module.js:', 'some', 'at ', '@', 'b', 'c', 'd', '\t' ], undefined );
  test.identical( got, 'at\n@\nb\nc\nd' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] > last index';
  var got = _.introspector.stack( [ '(vm.js: 12', '(module.js:', '(internal/module.js:', 'some', 'at ', '@', 'b', 'c', 'd', '\t' ], [ 0, 7 ] );
  test.identical( got, 'at\n@\nb\nc\nd' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] === last index';
  var got = _.introspector.stack( [ '(vm.js: 12', '(module.js:', '(internal/module.js:', 'some', 'at ', '@', 'b', 'c', 'd', '\t' ], [ 0, 4 ] );
  test.identical( got, 'at\n@\nb\nc' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] < last index';
  var got = _.introspector.stack( [ '(vm.js: 12', '(module.js:', '(internal/module.js:', 'some', 'at ', '@', 'b', 'c', 'd', '\t' ], [ 0, 1 ] );
  test.identical( got, 'at' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] < 0';
  var got = _.introspector.stack( [ '(vm.js: 12', '(module.js:', '(internal/module.js:', 'some', 'at ', '@', 'b', 'c', 'd', '\t' ], [ 0, -1 ] );
  test.identical( got, 'at\n@\nb\nc\nd' );

  test.case = 'range[ 0 ] - -3, range[ 1 ] > last index';
  var got = _.introspector.stack( [ '(vm.js: 12', '(module.js:', '(internal/module.js:', 'some', 'at ', '@', 'b', 'c', 'd', '\t' ], [ -3, 7 ] );
  test.identical( got, 'b\nc\nd' );

  test.case = 'range[ 0 ] - -3, range[ 1 ] === last index';
  var got = _.introspector.stack( [ '(vm.js: 12', '(module.js:', '(internal/module.js:', 'some', 'at ', '@', 'b', 'c', 'd', '\t' ], [ -3, 4 ] );
  test.identical( got, 'b\nc' );

  test.case = 'range[ 0 ] - -3, range[ 1 ] < last index';
  var got = _.introspector.stack( [ '(vm.js: 12', '(module.js:', '(internal/module.js:', 'some', 'at ', '@', 'b', 'c', 'd', '\t' ], [ -3, 1 ] );
  test.identical( got, '' );

  test.case = 'range[ 0 ] - -3, range[ 1 ] < 0';
  var got = _.introspector.stack( [ '(vm.js: 12', '(module.js:', '(internal/module.js:', 'some', 'at ', '@', 'b', 'c', 'd', '\t' ], [ -3, -1 ] );
  test.identical( got, 'b\nc\nd' );

  test.case = 'range[ 0 ] - 2, range[ 1 ] > last index';
  var got = _.introspector.stack( [ '(vm.js: 12', '(module.js:', '(internal/module.js:', 'some', 'at ', '@', 'b', 'c', 'd', '\t' ], [ 2, 7 ] );
  test.identical( got, 'b\nc\nd' );

  test.case = 'range[ 0 ] - 2, range[ 1 ] === last index';
  var got = _.introspector.stack( [ '(vm.js: 12', '(module.js:', '(internal/module.js:', 'some', 'at ', '@', 'b', 'c', 'd', '\t' ], [ 2, 4 ] );
  test.identical( got, 'b\nc' );

  test.case = 'range[ 0 ] - 2, range[ 1 ] < last index';
  var got = _.introspector.stack( [ '(vm.js: 12', '(module.js:', '(internal/module.js:', 'some', 'at ', '@', 'b', 'c', 'd', '\t' ], [ 2, 1 ] );
  test.identical( got, '' );

  test.case = 'range[ 0 ] - 2, range[ 1 ] < 0';
  var got = _.introspector.stack( [ '(vm.js: 12', '(module.js:', '(internal/module.js:', 'some', 'at ', '@', 'b', 'c', 'd', '\t' ], [ 2, -1 ] );
  test.identical( got, 'b\nc\nd' );

  test.close( 'stack - array, first element - has not "at" or "@"' );

  /* - */

  test.open( 'stack - array, first element - has "at" or "@"' );

  test.case = 'range - undefined';
  var got = _.introspector.stack( [ 'at ', '@', 'b', 'c', 'd', '\t' ], undefined );
  test.identical( got, 'at\n@\nb\nc\nd' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] > last index';
  var got = _.introspector.stack( [ 'at ', '@', 'b', 'c', 'd', '\t' ], [ 0, 7 ] );
  test.identical( got, 'at\n@\nb\nc\nd' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] === last index';
  var got = _.introspector.stack( [ 'at ', '@', 'b', 'c', 'd', '\t' ], [ 0, 4 ] );
  test.identical( got, 'at\n@\nb\nc' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] < last index';
  var got = _.introspector.stack( [ 'at ', '@', 'b', 'c', 'd', '\t' ], [ 0, 1 ] );
  test.identical( got, 'at' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] < 0';
  var got = _.introspector.stack( [ 'at ', '@', 'b', 'c', 'd', '\t' ], [ 0, -1 ] );
  test.identical( got, 'at\n@\nb\nc\nd' );

  test.case = 'range[ 0 ] - -3, range[ 1 ] > last index';
  var got = _.introspector.stack( [ 'some', 'at ', '@', 'b', 'c', 'd', '\t' ], [ -3, 7 ] );
  test.identical( got, 'b\nc\nd' );

  test.case = 'range[ 0 ] - -3, range[ 1 ] === last index';
  var got = _.introspector.stack( [ 'at ', '@', 'b', 'c', 'd', '\t' ], [ -3, 4 ] );
  test.identical( got, 'b\nc' );

  test.case = 'range[ 0 ] - -3, range[ 1 ] < last index';
  var got = _.introspector.stack( [ 'at ', '@', 'b', 'c', 'd', '\t' ], [ -3, 1 ] );
  test.identical( got, '' );

  test.case = 'range[ 0 ] - -3, range[ 1 ] < 0';
  var got = _.introspector.stack( [ 'at ', '@', 'b', 'c', 'd', '\t' ], [ -3, -1 ] );
  test.identical( got, 'b\nc\nd' );

  test.case = 'range[ 0 ] - 2, range[ 1 ] > last index';
  var got = _.introspector.stack( [ 'at ', '@', 'b', 'c', 'd', '\t' ], [ 2, 7 ] );
  test.identical( got, 'b\nc\nd' );

  test.case = 'range[ 0 ] - 2, range[ 1 ] === last index';
  var got = _.introspector.stack( [ 'at ', '@', 'b', 'c', 'd', '\t' ], [ 2, 4 ] );
  test.identical( got, 'b\nc' );

  test.case = 'range[ 0 ] - 2, range[ 1 ] < last index';
  var got = _.introspector.stack( [ 'at ', '@', 'b', 'c', 'd', '\t' ], [ 2, 1 ] );
  test.identical( got, '' );

  test.case = 'range[ 0 ] - 2, range[ 1 ] < 0';
  var got = _.introspector.stack( [ 'at ', '@', 'b', 'c', 'd', '\t' ], [ 2, -1 ] );
  test.identical( got, 'b\nc\nd' );

  test.close( 'stack - array, first element - has "at" or "@"' );

  /* - */

  test.open( 'only range' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] - Infinity';
  var got = _.introspector.stack( [ 0, Infinity ] );
  var arr = got.split( '\n' );
  test.gt( arr.length, 10 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 1 );

  test.case = 'range[ 0 ] - 0, range[ 1 ] - 100';
  var got = _.introspector.stack( [ 0, 100 ] );
  var arr = got.split( '\n' );
  test.gt( arr.length, 10 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 ); 
  test.identical( _.strCount( got, _.introspector.location().routineName ), 1 );

  test.case = 'range[ 0 ] - 0, range[ 1 ] - 10';
  var got = _.introspector.stack( [ 0, 10 ] );
  var arr = got.split( '\n' );
  test.identical( arr.length, 10 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 ); 
  test.identical( _.strCount( got, _.introspector.location().routineName ), 1 );

  test.case = 'range[ 0 ] - 0, range[ 1 ] - -1';
  var got = _.introspector.stack( [ 0, -1 ] );
  var arr = got.split( '\n' );
  test.gt( arr.length, 10 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 1 );

  /* */

  test.case = 'range[ 0 ] - 2, range[ 1 ] - Infinity';
  var got = _.introspector.stack( [ 2, Infinity ] );
  var arr = got.split( '\n' );
  test.gt( arr.length, 10 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'range[ 0 ] - 2, range[ 1 ] - 100';
  var got = _.introspector.stack( [ 2, 100 ] );
  var arr = got.split( '\n' );
  test.gt( arr.length, 10 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 ); 
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'range[ 0 ] - 2, range[ 1 ] - 10';
  var got = _.introspector.stack( [ 2, 10 ] );
  var arr = got.split( '\n' );
  test.identical( arr.length, 8 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 ); 
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'range[ 0 ] - 2, range[ 1 ] - -1';
  var got = _.introspector.stack( [ 2, -1 ] );
  var arr = got.split( '\n' );
  test.gt( arr.length, 10 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  /* */

  test.case = 'range[ 0 ] - -2, range[ 1 ] - Infinity';
  var got = _.introspector.stack( [ -2, Infinity ] );
  var arr = got.split( '\n' );
  test.le( arr.length, 2 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'range[ 0 ] - -2, range[ 1 ] - 100';
  var got = _.introspector.stack( [ -2, 100 ] );
  var arr = got.split( '\n' );
  test.le( arr.length, 2 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 ); 
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'range[ 0 ] - -2, range[ 1 ] - 10';
  var got = _.introspector.stack( [ -2, 10 ] );
  var arr = got.split( '\n' );
  test.identical( arr.length, 1 );
  test.is( arr[ 0 ].indexOf( 'at ') === -1 ); 
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'range[ 0 ] - -2, range[ 1 ] - -1';
  var got = _.introspector.stack( [ -2, -1 ] );
  var arr = got.split( '\n' );
  test.le( arr.length, 2 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.close( 'only range' );

  /* - */

  test.open( 'stack - null, range' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] - Infinity';
  var got = _.introspector.stack( null, [ 0, Infinity ] );
  var arr = got.split( '\n' );
  test.gt( arr.length, 10 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 1 );

  test.case = 'range[ 0 ] - 0, range[ 1 ] - 100';
  var got = _.introspector.stack( null, [ 0, 100 ] );
  var arr = got.split( '\n' );
  test.gt( arr.length, 10 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 ); 
  test.identical( _.strCount( got, _.introspector.location().routineName ), 1 );

  test.case = 'range[ 0 ] - 0, range[ 1 ] - 10';
  var got = _.introspector.stack( null, [ 0, 10 ] );
  var arr = got.split( '\n' );
  test.identical( arr.length, 10 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 ); 
  test.identical( _.strCount( got, _.introspector.location().routineName ), 1 );

  test.case = 'range[ 0 ] - 0, range[ 1 ] - -1';
  var got = _.introspector.stack( null, [ 0, -1 ] );
  var arr = got.split( '\n' );
  test.gt( arr.length, 10 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 1 );

  /* */

  test.case = 'range[ 0 ] - 2, range[ 1 ] - Infinity';
  var got = _.introspector.stack( null, [ 2, Infinity ] );
  var arr = got.split( '\n' );
  test.gt( arr.length, 10 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'range[ 0 ] - 2, range[ 1 ] - 100';
  var got = _.introspector.stack( null, [ 2, 100 ] );
  var arr = got.split( '\n' );
  test.gt( arr.length, 10 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 ); 
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'range[ 0 ] - 2, range[ 1 ] - 10';
  var got = _.introspector.stack( null, [ 2, 10 ] );
  var arr = got.split( '\n' );
  test.identical( arr.length, 8 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 ); 
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'range[ 0 ] - 2, range[ 1 ] - -1';
  var got = _.introspector.stack( null, [ 2, -1 ] );
  var arr = got.split( '\n' );
  test.gt( arr.length, 10 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  /* */

  test.case = 'range[ 0 ] - -2, range[ 1 ] - Infinity';
  var got = _.introspector.stack( null, [ -2, Infinity ] );
  var arr = got.split( '\n' );
  test.le( arr.length, 2 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'range[ 0 ] - -2, range[ 1 ] - 100';
  var got = _.introspector.stack( null, [ -2, 100 ] );
  var arr = got.split( '\n' );
  test.le( arr.length, 2 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 ); 
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'range[ 0 ] - -2, range[ 1 ] - 10';
  var got = _.introspector.stack( null, [ -2, 10 ] );
  var arr = got.split( '\n' );
  test.identical( arr.length, 1 );
  test.is( arr[ 0 ].indexOf( 'at ') === -1 ); 
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'range[ 0 ] - -2, range[ 1 ] - -1';
  var got = _.introspector.stack( null, [ -2, -1 ] );
  var arr = got.split( '\n' );
  test.le( arr.length, 2 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.close( 'stack - null, range' );

  /* - */

  test.open( 'stack - error, range' );

  test.case = 'range[ 0 ] - 0, range[ 1 ] - Infinity';
  var got = _.introspector.stack( new Error( 'Uncaught error' ), [ 0, Infinity ] );
  var arr = got.split( '\n' );
  test.gt( arr.length, 10 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 1 );

  test.case = 'range[ 0 ] - 0, range[ 1 ] - 100';
  var got = _.introspector.stack( new Error( 'Uncaught error' ), [ 0, 100 ] );
  var arr = got.split( '\n' );
  test.gt( arr.length, 10 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 ); 
  test.identical( _.strCount( got, _.introspector.location().routineName ), 1 );

  test.case = 'range[ 0 ] - 0, range[ 1 ] - 10';
  var got = _.introspector.stack( new Error( 'Uncaught error' ), [ 0, 10 ] );
  var arr = got.split( '\n' );
  test.identical( arr.length, 10 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 ); 
  test.identical( _.strCount( got, _.introspector.location().routineName ), 1 );

  test.case = 'range[ 0 ] - 0, range[ 1 ] - -1';
  var got = _.introspector.stack( new Error( 'Uncaught error' ), [ 0, -1 ] );
  var arr = got.split( '\n' );
  test.gt( arr.length, 10 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 1 );

  /* */

  test.case = 'range[ 0 ] - 2, range[ 1 ] - Infinity';
  var got = _.introspector.stack( new Error( 'Uncaught error' ), [ 2, Infinity ] );
  var arr = got.split( '\n' );
  test.gt( arr.length, 10 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'range[ 0 ] - 2, range[ 1 ] - 100';
  var got = _.introspector.stack( new Error( 'Uncaught error' ), [ 2, 100 ] );
  var arr = got.split( '\n' );
  test.gt( arr.length, 10 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 ); 
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'range[ 0 ] - 2, range[ 1 ] - 10';
  var got = _.introspector.stack( new Error( 'Uncaught error' ), [ 2, 10 ] );
  var arr = got.split( '\n' );
  test.identical( arr.length, 8 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 ); 
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'range[ 0 ] - 2, range[ 1 ] - -1';
  var got = _.introspector.stack( new Error( 'Uncaught error' ), [ 2, -1 ] );
  var arr = got.split( '\n' );
  test.gt( arr.length, 10 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  /* */

  test.case = 'range[ 0 ] - -2, range[ 1 ] - Infinity';
  var got = _.introspector.stack( new Error( 'Uncaught error' ), [ -2, Infinity ] );
  var arr = got.split( '\n' );
  test.le( arr.length, 2 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'range[ 0 ] - -2, range[ 1 ] - 100';
  var got = _.introspector.stack( new Error( 'Uncaught error' ), [ -2, 100 ] );
  var arr = got.split( '\n' );
  test.le( arr.length, 2 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 ); 
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'range[ 0 ] - -2, range[ 1 ] - 10';
  var got = _.introspector.stack( new Error( 'Uncaught error' ), [ -2, 10 ] );
  var arr = got.split( '\n' );
  test.identical( arr.length, 1 );
  test.is( arr[ 0 ].indexOf( 'at ') === -1 ); 
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'range[ 0 ] - -2, range[ 1 ] - -1';
  var got = _.introspector.stack( new Error( 'Uncaught error' ), [ -2, -1 ] );
  var arr = got.split( '\n' );
  test.le( arr.length, 2 );
  test.is( arr[ 0 ].indexOf( 'at ') !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.close( 'stack - error, range' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.introspector.stack( null, [ 1, 2 ], 'extra' ) );

  test.case = 'not a range';
  test.shouldThrowErrorSync( () => _.introspector.stack( [ 'at @' ] ) );
  test.shouldThrowErrorSync( () => _.introspector.stack( [ undefined, 1 ] ) );
  test.shouldThrowErrorSync( () => _.introspector.stack( [ '', 1 ] ) );
  test.shouldThrowErrorSync( () => _.introspector.stack( [ false, 1 ] ) );
  test.shouldThrowErrorSync( () => _.introspector.stack( [ true, 1 ] ) );
  test.shouldThrowErrorSync( () => _.introspector.stack( [ null, 1 ] ) );
  test.shouldThrowErrorSync( () => _.introspector.stack( [ 1, '' ] ) );
  test.shouldThrowErrorSync( () => _.introspector.stack( [ 1, undefined ] ) );
  test.shouldThrowErrorSync( () => _.introspector.stack( [ 1, false ] ) );
  test.shouldThrowErrorSync( () => _.introspector.stack( [ 1, true ] ) );
  test.shouldThrowErrorSync( () => _.introspector.stack( [ 1, null ] ) );
  test.shouldThrowErrorSync( () => _.introspector.stack( { notError : 1 } ) );
}

//

function stackFilter( test ) 
{
  test.open( 'onEach returns element' );

  test.case = 'only onEach';
  var got = _.introspector.stackFilter( ( e ) => e );
  test.is( got.indexOf( _.introspector.location().filePath ) !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 2 );

  test.case = 'stack is undefined';
  var got = _.introspector.stackFilter( undefined, ( e ) => e );
  test.is( got.indexOf( _.introspector.location().filePath ) !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 2 );

  test.case = 'stack is null';
  var got = _.introspector.stackFilter( undefined, ( e ) => e );
  test.is( got.indexOf( _.introspector.location().filePath ) !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 2 );

  test.case = 'stack is string';
  var got = _.introspector.stackFilter( 'at routine\n stack', ( e ) => e );
  test.is( got.indexOf( 'at routine' ) !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'stack is array';
  var got = _.introspector.stackFilter( [ 'at routine', ' stack' ], ( e ) => e );
  test.is( got.indexOf( 'at routine' ) !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'stack is error';
  var got = _.introspector.stackFilter( new Error(), ( e ) => e );
  test.is( got.indexOf( _.introspector.location().filePath ) !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 1 );

  test.close( 'onEach returns element' );

  /* - */

  test.open( 'onEach returns map with original field' );

  test.case = 'only onEach';
  var got = _.introspector.stackFilter( ( e, k ) => { return { original : e.original, key : k } } );
  test.is( got.indexOf( _.introspector.location().filePath ) !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 2 );

  test.case = 'stack is undefined';
  var got = _.introspector.stackFilter( undefined, ( e, k ) => { return { original : e.original, key : k } } );
  test.is( got.indexOf( _.introspector.location().filePath ) !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 2 );

  test.case = 'stack is null';
  var got = _.introspector.stackFilter( undefined, ( e, k ) => { return { original : e.original, key : k } } );
  test.is( got.indexOf( _.introspector.location().filePath ) !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 2 );

  test.case = 'stack is string';
  var got = _.introspector.stackFilter( 'at routine\n stack', ( e, k ) => { return { original : e.original, key : k } } );
  test.is( got.indexOf( 'at routine' ) !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'stack is array';
  var got = _.introspector.stackFilter( [ 'at routine', ' stack' ], ( e, k ) => { return { original : e.original, key : k } } );
  test.is( got.indexOf( 'at routine' ) !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 0 );

  test.case = 'stack is error';
  var got = _.introspector.stackFilter( new Error(), ( e, k ) => { return { original : e.original, key : k } } );
  test.is( got.indexOf( _.introspector.location().filePath ) !== -1 );
  test.identical( _.strCount( got, _.introspector.location().routineName ), 1 );

  test.close( 'onEach returns map with original field' );

  /* - */

  test.open( 'onEach returns key as string' );

  test.case = 'only onEach';
  var got = _.introspector.stackFilter( ( e, k ) => String( k ) );
  var arr = got.split( '\n' );
  test.identical( arr[ 0 ], '0' );
  test.identical( arr[ 1 ], '1' );

  test.case = 'stack is undefined';
  var got = _.introspector.stackFilter( undefined, ( e, k ) => String( k ) );
  var arr = got.split( '\n' );
  test.identical( arr[ 0 ], '0' );
  test.identical( arr[ 1 ], '1' );

  test.case = 'stack is null';
  var got = _.introspector.stackFilter( undefined, ( e, k ) => String( k ) );
  var arr = got.split( '\n' );
  test.identical( arr[ 0 ], '0' );
  test.identical( arr[ 1 ], '1' );

  test.case = 'stack is string';
  var got = _.introspector.stackFilter( 'at routine\n stack', ( e, k ) => String( k ) );
  var arr = got.split( '\n' );
  test.identical( arr[ 0 ], '0' );
  test.identical( arr[ 1 ], '1' );

  test.case = 'stack is array';
  var got = _.introspector.stackFilter( [ 'at routine', ' stack' ], ( e, k ) => String( k ) );
  var arr = got.split( '\n' );
  test.identical( arr[ 0 ], '0' );
  test.identical( arr[ 1 ], '1' );

  test.case = 'stack is error';
  var got = _.introspector.stackFilter( new Error(), ( e, k ) => String( k ) );
  var arr = got.split( '\n' );
  test.identical( arr[ 0 ], '0' );
  test.identical( arr[ 1 ], '1' );

  test.close( 'onEach returns key as string' );

  /* - */

  test.open( 'onEach returns undefined' );

  test.case = 'only onEach';
  var got = _.introspector.stackFilter( ( e, k ) => undefined );
  test.identical( got, '' );

  test.case = 'stack is undefined';
  var got = _.introspector.stackFilter( undefined, ( e, k ) => undefined );
  test.identical( got, '' );

  test.case = 'stack is null';
  var got = _.introspector.stackFilter( undefined, ( e, k ) => undefined );
  test.identical( got, '' );

  test.case = 'stack is string';
  var got = _.introspector.stackFilter( 'at routine\n stack', ( e, k ) => undefined );
  test.identical( got, '' );

  test.case = 'stack is array';
  var got = _.introspector.stackFilter( [ 'at routine', ' stack' ], ( e, k ) => undefined );
  test.identical( got, '' );

  test.case = 'stack is error';
  var got = _.introspector.stackFilter( new Error(), ( e, k ) => undefined );
  test.identical( got, '' );

  test.close( 'onEach returns undefined' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.introspector.stackFilter() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.introspector.stackFilter( undefined, ( e ) => e, 'extra' ) );

  test.case = 'stack is not a stack';
  test.shouldThrowErrorSync( () => _.introspector.stackFilter( { original : '/usr/bin/' }, ( e ) => e ) );

  test.case = 'onEach is not a routine';
  test.shouldThrowErrorSync( () => _.introspector.stackFilter( 'at routine stackFilter\n at @233', 'wrong' ) );

  test.case = 'onEach returns wrong value';
  test.shouldThrowErrorSync( () => _.introspector.stackFilter( 'at routine stackFilter\n at @233', ( e, k ) => [ e, k ] ) );

  test.case = 'onEach returns object without original field';
  test.shouldThrowErrorSync( () => _.introspector.stackFilter( 'at routine stackFilter\n at @233', ( e, k ) => { return {  element : e.original, key : k } } ) );

  test.case = 'onEach returns object, original field is not a string';
  test.shouldThrowErrorSync( () => _.introspector.stackFilter( 'at routine stackFilter\n at @233', ( e, k ) => { return { original : e, key : k } } ) );
}

// --
// declare
// --

var Self =
{

  name : 'Tools.base.Introspector',
  silencing : 1,

  onSuiteBegin,
  onSuiteEnd,

  context :
  {
    // nameOfFile : _.introspector.location().fileName, /* xxx */
    suiteTempPath : null,
    assetsOriginalSuitePath : null,
    execJsPath : null,
  },

  tests :
  {

    /* qqq : implement test routine for _.err */

    stackBasic,
    stack, /* qqq : extend the routine | Dmytro : extended */

    locationFromStackFrame,

    stackFilter,

  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
