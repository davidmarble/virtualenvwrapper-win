
Call/dependency graph
=====================


.. graphviz::

    digraph G {
        node[fontsize=40,shape=box]

        "cd-" -> {cdproject; cdsitepackages; cdvirtualenv; }
        mkproject -> mkvirtualenv;
        mkvirtualenv -> setprojectdir;
        rmvirtualenv;
        setprojectdir;
    }
