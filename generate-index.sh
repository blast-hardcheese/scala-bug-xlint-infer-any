export versions=(
  2.10.7  # Correct
  2.11.0  # Incorrect
  2.11.12 # "
  2.12.10 # "
  2.13.6  # "
  3.0.0   # "
)

strip_colors() {
  sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g'
}

cat >README.md <<!
Infer Any/AnyVal warning suppressed by inclusion in Unit block.
===

Code
---

\`\`\`scala
$(cat src/main/scala/Bogus.scala)
\`\`\`

Description
---

The same line, \`Option.empty[String].contains(1234)\`, conditionally emits
warnings depending on whether it is contained in a block that returns \`Unit\`.

Identical -Xlint:infer-any settings across 2.11, 2.12, 2.13 show only one warning, where 2.10.7 correctly reports three warnings.

3.0 does not immediately present an alternative to \`-Xlint:infer-any\` ([the migration notes just say \`X\`](https://docs.scala-lang.org/scala3/guides/migration/options-lookup.html)), but included in the output here for completeness.

Compiler results:
---
!

(for version in ${versions[@]}; do
  arg="++${version}; clean; compile"
  echo
  echo "### ${version}"
  echo "user$ sbtn \"$arg\""
  echo '```'
  sbtn "$arg" | strip_colors
  echo '```'
done) >> README.md
