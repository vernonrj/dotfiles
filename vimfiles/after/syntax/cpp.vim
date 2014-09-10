" uppercase types that pop up everywhere
syn keyword cType += UINT8 UINT16 UINT32 UINT64
syn keyword cType += INT8 INT16 INT32 INT64
syn keyword cType += BOOL
" microsoft-specific types
syn keyword cType += _bstr_t hyper
" syn keyword cppBoolean += ON OFF
" syn match   cppMember "\W\@<=m_\w*"
syn match   Define    "\W\@<=[A-Z][A-Z0-9_]*\W\@="

" hi def link cppMember Underlined

