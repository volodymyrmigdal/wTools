( function _l8_Routine_s_()
{

'use strict';

let _global = _global_;
let _ = _global_.wTools;
let Self = _global_.wTools;
let Routine = _global_.wTools.routine = _global_.wTools.routine || Object.create( null );
let RoutineS = _global_.wTools.routine.s = _global_.wTools.routine.s || Object.create( null );

// --
// routine
// --

function routineCallButOnly( /* context, routine, options, but, only */ )
{
  let context = arguments[ 0 ];
  let routine = arguments[ 1 ];
  let options = arguments[ 2 ];
  let but = arguments[ 3 ];
  let only = arguments[ 4 ];

  if( _.routine.is( routine ) || _.strIs( routine ) )
  {

    _.assert( arguments.length === 3 || arguments.length === 4 || arguments.length === 5 );
    _.assert( _.mapIs( options ) );

    if( _.strIs( routine ) )
    routine = context[ routine ];

  }
  else
  {

    routine = arguments[ 0 ];
    options = arguments[ 1 ];
    but = arguments[ 2 ];
    only = arguments[ 3 ];

    _.assert( arguments.length === 2 || arguments.length === 3 || arguments.length === 4 );
    _.assert( _.mapIs( options ) );

  }

  _.assert( _.routine.is( routine ) );

  if( !only )
  only = routine.defaults

  if( but )
  options = _.mapBut( options, but )
  if( only )
  options = _.mapOnly( options, only )

  return routine.call( context, options );
}

//

function _routinesComposeWithSingleArgument_head( routine, args )
{
  let o = _.routine.s.compose.head.call( this, routine, args );

  _.assert( args.length === 1 );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  return o;
}

//

function routinesComposeReturningLast()
{
  let o = _.routine.s.composeReturningLast.head( routinesComposeReturningLast, arguments );
  let result = _.routine.s.composeReturningLast.body( o );
  return result;
}

routinesComposeReturningLast.head = _.routine.s.compose.head;
routinesComposeReturningLast.body = _.routine.s.compose.body;
routinesComposeReturningLast.defaults = Object.create( _.routine.s.compose.defaults );

routinesComposeReturningLast.defaults.supervisor = _.compose.supervisor.returningLast;

function routinesComposeAll()
{
  let o = _.routine.s.composeAll.head( routinesComposeAll, arguments );
  let result = _.routine.s.composeAll.body( o );
  return result;
}

routinesComposeAll.head = _routinesComposeWithSingleArgument_head;
routinesComposeAll.body = _.routine.s.compose.body;

var defaults = routinesComposeAll.defaults = Object.create( _.routine.s.compose.defaults );
defaults.chainer = _.compose.chainer.composeAll;
defaults.supervisor = _.compose.supervisor.composeAll;

_.assert( _.routine.is( _.compose.chainer.originalWithDont ) );
_.assert( _.routine.is( _.compose.supervisor.composeAll ) );

//

function routinesComposeAllReturningLast()
{
  let o = _.routine.s.composeAllReturningLast.head( routinesComposeAllReturningLast, arguments );
  let result = _.routine.s.composeAllReturningLast.body( o );
  return result;
}

routinesComposeAllReturningLast.head = _routinesComposeWithSingleArgument_head;
routinesComposeAllReturningLast.body = _.routine.s.compose.body;

var defaults = routinesComposeAllReturningLast.defaults = Object.create( _.routine.s.compose.defaults );
defaults.chainer = _.compose.chainer.originalWithDont;
defaults.supervisor = _.compose.supervisor.returningLast;

//

function routinesChain()
{
  let o = _.routine.s.chain.head( routinesChain, arguments );
  let result = _.routine.s.chain.body( o );
  return result;
}

routinesChain.head = _routinesComposeWithSingleArgument_head;
routinesChain.body = _.routine.s.compose.body;

var defaults = routinesChain.defaults = Object.create( _.routine.s.compose.defaults );
defaults.chainer = _.compose.chainer.chaining;
defaults.supervisor = _.compose.supervisor.chaining;

//

function _equalizerFromMapper( mapper )
{

  if( mapper === undefined )
  mapper = function mapper( a, b ){ return a === b };

  _.assert( 0, 'not tested' )
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( mapper.length === 1 || mapper.length === 2 );

  if( mapper.length === 1 )
  {
    let equalizer = equalizerFromMapper;
    return equalizer;
  }

  return mapper;

  function equalizerFromMapper( a, b )
  {
    return mapper( a ) === mapper( b );
  }
}

//

function _comparatorFromEvaluator( evaluator )
{

  if( evaluator === undefined )
  evaluator = function comparator( a, b ){ return a-b };

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( evaluator.length === 1 || evaluator.length === 2 );

  if( evaluator.length === 1 )
  {
    let comparator = comparatorFromEvaluator;
    return comparator;
  }

  return evaluator;

  function comparatorFromEvaluator( a, b )
  {
    return evaluator( a ) - evaluator( b );
  }
}

// --
// extension
// --

let ExtensionTools =
{

  routineCallButOnly, /* qqq : cover please */

  routinesComposeReturningLast,
  routinesComposeAll,
  routinesComposeAllReturningLast, /* xxx */
  routinesChain,

  _equalizerFromMapper,
  _comparatorFromEvaluator, /* xxx : move out */

}

//

let Extension =
{

  callButOnly : routineCallButOnly, /* qqq : cover please */

  _equalizerFromMapper,
  _comparatorFromEvaluator, /* xxx : move out */

}

//

let ExtensionS =
{

  composeReturningLast : routinesComposeReturningLast,
  composeAll : routinesComposeAll,
  composeAllReturningLast : routinesComposeAllReturningLast, /* xxx */
  chain : routinesChain,

}

Object.assign( Self, ExtensionTools );
Object.assign( Routine, Extension );
Object.assign( RoutineS, ExtensionS );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = _;

})();
