===========================================
JuMP --- Julia for Mathematical Programming
===========================================

.. module:: JuMP
   :synopsis: Julia for Mathematical Programming

`JuMP <https://github.com/JuliaOpt/JuMP.jl>`_ is a domain-specific modeling language for
`mathematical programming <http://en.wikipedia.org/wiki/Mathematical_optimization>`_
embedded in `Julia <http://julialang.org/>`_.
It currently supports a number of open-source and commercial solvers (see below)
for a variety of problem classes, including **linear programming**, **mixed-integer programming**, **second-order conic programming**, and **nonlinear programming**.
JuMP's features include:

* User friendliness

  * Syntax that mimics natural mathematical expressions.
  * Complete documentation.

* Speed

  * Benchmarking has shown that JuMP can create problems at similar speeds to
    special-purpose modeling languages such as `AMPL <http://www.ampl.com/>`_.
  * JuMP communicates with solvers in memory, avoiding the need to write
    intermediary files.

* Solver independence

  * JuMP uses a generic solver-independent interface provided by the
    `MathProgBase <https://github.com/mlubin/MathProgBase.jl>`_ package, making it easy
    to change between a number of open-source and commercial optimization software packages ("solvers").
  * Currently supported solvers include `Cbc <https://projects.coin-or.org/Cbc>`_,
    `Clp <https://projects.coin-or.org/Clp>`_,
    `CPLEX <http://www-01.ibm.com/software/commerce/optimization/cplex-optimizer/>`_,
    `ECOS <https://github.com/ifa-ethz/ecos>`_,
    `GLPK <http://www.gnu.org/software/glpk/>`_,
    `Gurobi <http://www.gurobi.com>`_,
    `Ipopt <https://projects.coin-or.org/Ipopt>`_,
    `KNITRO <http://www.ziena.com/knitro.htm>`_,
    `MOSEK <http://www.mosek.com/>`_,
    and `NLopt <http://ab-initio.mit.edu/wiki/index.php/NLopt>`_.

* Access to advanced algorithmic techniques

  * Including :ref:`efficient LP re-solves <probmod>` and :ref:`callbacks for mixed-integer programming <callbacks>` which previously required using solver-specific and/or low-level C++ libraries.

* Ease of embedding

  * JuMP itself is written purely in Julia. Solvers are the only binary dependencies.
  * Being embedded in a general-purpose programming language makes it easy to solve optimization problems as part of a larger workflow (e.g., inside a simulation, behind a web server, or as a subproblem in a decomposition algorithm).

    * As a trade-off, JuMP's syntax is constrained by the syntax available in Julia.

  * JuMP is LGPL licensed, meaning that it can be embedded in commercial software that complies with the terms of the license.

While neither Julia nor JuMP have reached version 1.0 yet, the releases are stable enough for everyday use and are being used in a number of research projects and neat applications by a growing community of users who are early adopters. JuMP remains under active development, and we welcome your feedback, suggestions, and bug reports.

Installing JuMP
---------------

If you are familiar with Julia you can get started quickly by using the
package manager to install JuMP::

    julia> Pkg.add("JuMP")

And a solver, e.g.::

    julia> Pkg.add("Clp")  # Will install Cbc as well

Then read the :ref:`quick-start` and/or see a :ref:`simple-example`.
The subsequent sections detail the complete functionality of JuMP.

Contents
--------

.. toctree::
    :maxdepth: 2

    installation.rst
    quickstart.rst
    refmodel.rst
    refvariable.rst
    refexpr.rst
    probmod.rst
    callbacks.rst
    nlp.rst

-----------
Citing JuMP
-----------

Further discussion of the design of JuMP in the context of existing domain-specific languages for mathematical programming, together with extensive benchmarks, is given in [1]_. If you find JuMP useful in your work, we request that you cite this paper.


.. [1] M. Lubin and I. Dunning, "Computing in Operations Research using Julia", INFORMS Journal on Computing, to appear, 2014. `arXiv:1312.1431 <http://arxiv.org/abs/1312.1431>`_
