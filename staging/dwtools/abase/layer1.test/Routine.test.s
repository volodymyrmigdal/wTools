( function _Routine_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

  var _ = _global_.wTools;

  _.include( 'wTesting' );

}
var _global = _global_;
var _ = _global_.wTools;

//

function testFunction1( x, y )
{
  return x + y
}

function testFunction2( x, y )
{
  return this;
}

function testFunction3( x, y )
{
  return x + y + this.k;
}

function testFunction4( x, y )
{
  return this;
}

function contextConstructor3()
{
  this.k = 15
}

var context3 = new contextConstructor3();

//

function _routineJoin( test )
{

  var testParam1 = 2,
    testParam2 = 4,
    options1 =
    {
      seal : false,
      routine : testFunction1,
      args : [ testParam2 ] // x
    },
    options2 =
    {
      seal : true,
      routine : testFunction2,
      args : [ testParam2 ] // x
    },

    options3 =
    {
      seal : false,
      routine : testFunction3,
      args : [ testParam2 ], // x
      context : context3
    },
    options4 =
    {
      seal : false,
      routine : testFunction4,
      args : [ testParam2 ], // x
      context : context3
    },

    options5 =
    {
      seal : true,
      routine : testFunction3,
      args : [ testParam1, testParam2 ], // x
      context : context3
    },

    wrongOpt1 = {
      seal : true,
      routine : {},
      args : [ testParam1, testParam2 ], // x
      context : context3
    },

    wrongOpt2 = {
      seal : true,
      routine : testFunction3,
      args : 'wrong', // x
      context : context3
    },

    expected1 = 6,
    expected2 = undefined,
    expected3 = 21,
    expected5 = 21;

  test.case = 'simple function without context with arguments bind without seal : result check';
  var gotfn = _._routineJoin( options1 );
  var got = gotfn( testParam1 );
  test.identical( got,expected1 );

  test.case = 'simple function without context and seal : context test';
  var gotfn = _._routineJoin(options2);
  var got = gotfn( testParam1 );
  test.identical( got, expected2 );

  test.case = 'simple function with context and arguments : result check';
  var gotfn = _._routineJoin(options3);
  var got = gotfn( testParam1 );
  test.identical( got, expected3 );

  test.case = 'simple function with context and arguments : context check';
  var gotfn = _._routineJoin(options4);
  var got = gotfn( testParam1 );
  test.identical( got instanceof contextConstructor3, true );

  test.case = 'simple function with context and arguments : result check, seal == true ';
  var gotfn = _._routineJoin(options5);
  var got = gotfn( testParam1 );
  test.identical( got, expected5 );

  /**/

  if( !Config.debug )
  return;

  test.case = 'missed argument';
  test.shouldThrowError( function()
  {
    _._routineJoin();
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _._routineJoin( options1, options2 );
  });

  test.case = 'passed non callable object';
  test.shouldThrowError( function()
  {
    _._routineJoin( wrongOpt1 );
  });

  test.case = 'passed arguments as primitive value';
  test.shouldThrowError( function()
  {
    _._routineJoin( wrongOpt2 );
  });

};

//
//
// function routineBind( test )
// {
//
//   var testParam1 = 2,
//     testParam2 = 4,
//     expected1 = 6,
//     expected2 = undefined,
//     expected3 = 21;
//
//   test.case = 'simple function without context with arguments bind : result check';
//   var gotfn = _.routineBind( testFunction1, undefined, [ testParam2 ]);
//   var got = gotfn( testParam1 );
//   test.identical( got,expected1 );
//
//   test.case = 'simple function without context : context test';
//   var gotfn = _.routineBind(testFunction2, undefined, [ testParam2 ]);
//   var got = gotfn( testParam1 );
//   test.identical( got, expected2 );
//
//   test.case = 'simple function with context and arguments : result check';
//   var gotfn = _.routineBind(testFunction3, context3, [ testParam2 ]);
//   var got = gotfn( testParam1 );
//   test.identical( got, expected3 );
//
//   test.case = 'simple function with context and arguments : context check';
//   var gotfn = _.routineBind(testFunction4, context3, [ testParam2 ]);
//   var got = gotfn( testParam1 );
//   test.identical( got instanceof contextConstructor3, true );
//
//   if( !Config.debug )
//   return;
//
//   test.case = 'missed argument';
//   test.shouldThrowError( function()
//   {
//     _.routineBind();
//   });
//
//   test.case = 'extra argument';
//   test.shouldThrowError( function()
//   {
//     _.routineBind( testFunction4, context3, [ testParam2 ], [ testParam1 ] );
//   });
//
//   test.case = 'passed non callable object';
//   test.shouldThrowError( function()
//   {
//     _.routineBind( {}, context3, [ testParam2 ] );
//   });
//
//   test.case = 'passed arguments as primitive value';
//   test.shouldThrowError( function()
//   {
//     _.routineBind( testFunction4, context3, testParam2 );
//   });
//
// };

//

function routineJoin( test )
{

  var testParam1 = 2,
    testParam2 = 4,
    expected1 = 6,
    expected2 = undefined,
    expected3 = 21;

  test.case = 'simple function without context with arguments bind : result check';
  var gotfn = _.routineJoin( undefined, testFunction1, [ testParam2 ]);
  var got = gotfn( testParam1 );
  test.identical( got,expected1 );

  test.case = 'simple function without context : context test';
  var gotfn = _.routineJoin(undefined, testFunction2, [ testParam2 ]);
  var got = gotfn( testParam1 );
  test.identical( got, expected2 );

  test.case = 'simple function with context and arguments : result check';
  var gotfn = _.routineJoin(context3, testFunction3, [ testParam2 ]);
  var got = gotfn( testParam1 );
  test.identical( got, expected3 );

  test.case = 'simple function with context and arguments : context check';
  var gotfn = _.routineJoin(context3, testFunction4, [ testParam2 ]);
  var got = gotfn( testParam1 );
  test.identical( got instanceof contextConstructor3, true );

  if( !Config.debug )
  return;

  test.case = 'missed argument';
  test.shouldThrowError( function()
  {
    _.routineJoin();
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.routineJoin( context3, testFunction4, [ testParam2 ], [ testParam1 ] );
  });

  test.case = 'passed non callable object';
  test.shouldThrowError( function()
  {
    _.routineJoin( context3, {}, [ testParam2 ] );
  });

  test.case = 'passed arguments as primitive value';
  test.shouldThrowError( function()
  {
    _.routineJoin( context3, testFunction4, testParam2 );
  });

}

//

function routineSeal(test)
{

  var testParam1 = 2,
    testParam2 = 4,
    expected1 = 6,
    expected2 = undefined,
    expected3 = 21;

  test.case = 'simple function with seal arguments : result check';
  var gotfn = _.routineSeal(undefined, testFunction1, [testParam1, testParam2]);
  var got = gotfn( testParam1 );
  test.identical( got, expected1 );

  test.case = 'simple function with seal arguments : context check';
  var gotfn = _.routineSeal(undefined, testFunction2, [testParam1, testParam2]);
  var got = gotfn( testParam1 );
  test.identical( got, expected2 );

  test.case = 'simple function with seal context and arguments : result check';
  var gotfn = _.routineSeal(context3, testFunction3, [testParam1, testParam2]);
  var got = gotfn( testParam1 );
  test.identical( got, expected3 );

  test.case = 'simple function with seal context and arguments : context check';
  var gotfn = _.routineSeal(context3, testFunction4, [testParam1, testParam2]);
  var got = gotfn( testParam1 );
  test.identical( got instanceof contextConstructor3, true );

  if( !Config.debug )
  return;

  test.case = 'missed argument';
  test.shouldThrowError( function()
  {
    _.routineSeal();
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.routineSeal( context3, testFunction4, [ testParam2 ], [ testParam1 ] );
  });

  test.case = 'passed non callable object';
  test.shouldThrowError( function()
  {
    _.routineSeal( context3, {}, [ testParam1, testParam2 ] );
  });

  test.case = 'passed arguments as primitive value';
  test.shouldThrowError( function()
  {
    _.routineSeal( context3, testFunction4, testParam2 );
  });

}

//

function routinesCall( test )
{

  var value1 = 'result1';
  var value2 = 4;
  var value3 = 5;

  function function1()
  {
    return value1;
  }

  function function2()
  {
    return value2;
  }

  function function3()
  {
    return value3;
  }

  function function5(x, y)
  {
    return x + y * this.k;
  }

  var function4 = testFunction3
  var function6 = testFunction4;

  var expected1 = [ value1 ],
    expected2 = [ value2 + value3 + context3.k ],
    expected3 = [ value1, value2, value3 ],
    expected4 =
    [
      value2 + value3 + context3.k,
      value2 + value3 * context3.k,
      context3
    ];

  test.case = 'call single function without arguments and context';
  debugger;
  var got = _.routinesCall( function1 );
  debugger;
  test.identical( got, expected1 );

  test.case = 'call single function with context and arguments';
  var got = _.routinesCall( context3, testFunction3, [value2, value3] );
  test.identical( got, expected2 );

  test.case = 'call functions without context and arguments';
  var got = _.routinesCall( [ function1, function2, function3 ] );
  test.identical( got, expected3 );

  test.case = 'call functions with context and arguments';
  var got = _.routinesCall( context3, [ function4, function5, function6 ], [value2, value3] );
  test.identical( got, expected4 );

  if( !Config.debug )
  return;

  test.case = 'missed argument';
  test.shouldThrowError( function()
  {
    _.routinesCall();
  });

  test.case = 'extra argument';
  test.shouldThrowError( function()
  {
    _.routinesCall(
      context3,
      [ function1, function2, function3 ],
      [ function4, function5, function6 ],
      [value2, value3]
    );
  });

  test.case = 'passed non callable object';
  test.shouldThrowError( function()
  {
    _.routinesCall( null );
  });

  test.case = 'passed arguments as primitive value (no wrapped into array)';
  test.shouldThrowError( function()
  {
     _.routinesCall( context3, testFunction3, value2 )
  });

}

//

function routinesCompose( test )
{

  function r1()
  {
    for( var a = 0 ; a < arguments.length ; a++ )
    counter += arguments[ a ];
    debugger;
    return _.unrollAppend( null, arguments, counter );
  }

  function r2()
  {
    for( var a = 0 ; a < arguments.length ; a++ )
    counter += 2*arguments[ a ];
    return counter;
  }

  function chainer( e, k, args, o )
  {
    return e;
  }

  /* - */

  test.case = 'without chainer';

  var counter = 0;
  var routines = [ null, r1, null, r2, null ];
  var composition = _.routinesCompose( routines );
  var got = composition( 1,2,3 );
  var expected = [ _.unrollAppend([ 1,2,3,6 ]), 18 ];
  test.identical( got, expected );
  test.identical( counter, 18 );

  /* - */

  test.case = 'with chainer';

  var counter = 0;
  var routines = [ null, r1, null, r2, null ];
  var composition = _.routinesCompose( routines, chainer );
  var got = composition( 1,2,3 );
  var expected = [ _.unrollAppend([ 1,2,3,6 ]), 30 ];
  test.identical( got, expected );
  test.identical( counter, 30 );

}

//

var Self =
{

  name : 'Tools/base/layer1/Routine',
  silencing : 1,

  tests :
  {

    _routineJoin : _routineJoin,
    // routineBind  : routineBind,
    routineJoin  : routineJoin,
    routineSeal  : routineSeal,
    routinesCall : routinesCall,

    routinesCompose : routinesCompose,

  }

};

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
