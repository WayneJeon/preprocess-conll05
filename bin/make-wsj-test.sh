#! /bin/tcsh

# section for development  
set SECTIONS = "wsj"

# name of the output file 
set FILE = "test.wsj" 

foreach s ( $SECTIONS )

    echo Processing section $s

    zcat $CONLL05/test.$s/words/test.$s.words.gz > /tmp/$$.words
    zcat $CONLL05/test.$s/props/test.$s.props.gz > /tmp/$$.props

    ## Choose syntax
    # zcat $CONLL05/devel/synt.col2/devel.$s.synt.col2.gz > /tmp/$$.synt
    # zcat $CONLL05/devel/synt.col2h/devel.$s.synt.col2h.gz > /tmp/$$.synt
    # zcat $CONLL05/devel/synt.upc/devel.$s.synt.upc.gz > /tmp/$$.synt
    # zcat $CONLL05/devel/synt.cha/devel.$s.synt.cha.gz > /tmp/$$.synt

    # Use gold syntax
    zcat $CONLL05/test/synt/test.$s.synt.wsj.gz > /tmp/$$.synt

    # no senses, set to null
    zcat $CONLL05/test.$s/null/test.$s.null.gz > /tmp/$$.senses
    zcat $CONLL05/test.$s/ne/test.$s.ne.gz > /tmp/$$.ne

    paste -d ' ' /tmp/$$.words /tmp/$$.synt /tmp/$$.ne /tmp/$$.senses /tmp/$$.props | gzip> /tmp/$$.section.$s.gz
end

echo Generating gzipped file $CONLL05/$FILE.gz
zcat /tmp/$$.section* | gzip -c > $CONLL05/$FILE.gz

echo Cleaning files
rm -f /tmp/$$*

