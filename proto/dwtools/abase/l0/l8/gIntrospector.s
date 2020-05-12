(function _gIntrospector_s_() {

'use strict';

let _global = _global_;
let _ = _global.wTools;
let Self = _.introspector = _.introspector || Object.create( null );

// --
// diagnostics
// --

let _diagnosticCodeExecuting = 0;
function code( o )
{

  _.routineOptions( code, o );
  _.assert( arguments.length === 0 || arguments.length === 1 );

  if( _diagnosticCodeExecuting )
  return;
  _diagnosticCodeExecuting += 1;

  try
  {

    if( !o.location )
    {
      if( o.error )
      o.location = _.introspector.location({ error : o.error, level : o.level });
      else
      o.location = _.introspector.location({ stack : o.stack, level : o.stack ? o.level : o.level+1 });
    }

    if( !_.numberIs( o.location.line ) )
    return end();

    /* */

    if( !o.sourceCode )
    {

      if( !o.location.filePath )
      return end();

      let codeProvider = _.codeProvider || _.fileProvider;
      if( !codeProvider && _global_._testerGlobal_ && _global_._testerGlobal_.wTools )
      codeProvider = _global_._testerGlobal_.wTools.codeProvider || _global_._testerGlobal_.wTools.fileProvider;

      if( !codeProvider )
      return end();

      try
      {

        let filePath = codeProvider.path.normalizeTolerant( o.location.filePath );
        if( codeProvider.path.isAbsolute( filePath ) )
        o.sourceCode = read( codeProvider, filePath );

      }
      catch( err )
      {
        o.sourceCode = ` ! Cant load source code of "${ o.location.filePath }"`;
      }

      if( !o.sourceCode )
      return end();

    }

    /* */

    let code = _.strLinesSelect
    ({
      src : o.sourceCode,
      line : o.location.line,
      numberOfLines : o.numberOfLines,
      selectMode : o.selectMode,
      zeroLine : 1,
      numbering : 1,
    });

    if( code && _.strLinesIndentation && o.identation )
    code = o.identation + _.strLinesIndentation( code, o.identation );

    let result = code;
    if( o.withPath )
    {
      if( o.asMap )
      result = { path : o.location.filePathLineCol, code };
      else
      result = o.location.filePathLineCol + '\n' + code;
    }

    return end( result );
  }
  catch( err )
  {
    console.log( err.toString() );
    return;
  }

  /* */

  function end( result )
  {
    _diagnosticCodeExecuting -= 1;
    return result;
  }

  /* */

  function read( codeProvider, filePath )
  {
    let result = codeProvider.fileRead
    ({
      filePath,
      sync : 1,
      throwing : 0,
    });
    return result;
  }

  /* */

}

code.defaults =
{
  level : 0,
  numberOfLines : 5,
  withPath : 1,
  asMap : 0,
  selectMode : 'center',
  identation : null,
  stack : null,
  error : null,
  location : null,
  sourceCode : null,
}

//

function memoryUsageInfo()
{
  var usage = process.memoryUsage();
  return ( usage.heapUsed >> 20 ) + ' / ' + ( usage.heapTotal >> 20 ) + ' / ' + ( usage.rss >> 20 ) + ' Mb';
}

// --
// declare
// --

let Extension =
{

  code,
  memoryUsageInfo,

}

Object.assign( _.introspector, Extension );

// --
// export
// --

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = _;

})();
