{Macro} = require './macro'
{Reference} = require './reference'
{isArray} = require './types'
{Primitive} = require './primitive'

quote = new Primitive (body, env, evaluate) ->
    throw new SyntaxError unless body.length is 1
    body[0]

quasiquote = new Macro (body, env) ->
    for stx in body
        if isUnquoted stx, env
            stx[1..]
        else
            [ new Reference(quote), stx ]

unquote = new Macro (body, env) ->
    throw new Error "Unquote should only be inside a quasiquote"

isUnquoted = (stx, env) ->
    isArray(stx) and stx.length > 0 and env.get(stx[0], null) is unquote

module.exports =
    quote: quote
    quasiquote: quasiquote
    unquote: unquote

console.log('quote.coffee')