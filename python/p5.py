import re
def markup(source,prev=True):
	by_block=re.compile(r'\n{2,}')
	blocks=by_block.split(source)
	
	par=re.compile(r'[^\s>]')
	bquote=re.compile(r'^(>\s+)\S')
	code=re.compile(r'^(\s+)\S')

	em=re.compile('[^\\])\*([^\*]+[^\\])\*')

	output_blocks=[]
	print("Blocks: ", blocks)
	for block in blocks:
		blines=block.split('\n')
		firstline=blines[0]

		if(par.match(firstline)):
			if(prev): output_blocks.append('\n<p>' + (markup(block,False) if len(blocks)>1 else block) + '</p>')
			else: output_blocks.append(block)

		if(bquote.match(firstline)):
			indent=bquote.match(firstline).span(1)[1]
			arg='\n'.join([bline[indent:] for bline in blines])
			if (prev): output_blocks.append('\n<blockquote>' + (markup(arg,True) ) +'</blockquote>')
			else: output.append(block)

		if(code.match(firstline)):
			indent=code.match(firstline).span(1)[1]
			arg='\n'.join([bline[indent:] for bline in blines])
			output_blocks.append('\n<pre><code>' + (markup(arg, False) ) + '</code></pre>')

	return '\n'.join(output_blocks)

txt="""> the physics department
> for biological methods
>
> > for generating
> > entropy
> >
> > based
> >
> >     on &embedded&
> >     <code> `with backticks`
>
>
>
> and_hitchhiking_around
"""
print(markup(txt))
