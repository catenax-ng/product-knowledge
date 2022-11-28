//
// Application to provide REST APIs as SPARQL services
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package it.unibz.inf.ontop.generation.normalization.impl;

import com.google.inject.Inject;
import it.unibz.inf.ontop.generation.normalization.DialectExtraNormalizer;
import it.unibz.inf.ontop.iq.IQTree;
import it.unibz.inf.ontop.utils.VariableGenerator;

/**
 * Ontop Normalizer which makes the druid optimizer happy.
 * TODO single joins per value binding
 */
public class DruidNormalizer implements DialectExtraNormalizer {

    private final TypingNullsDialectExtraNormalizer typingNullNormalizer;
    private final SubQueryFromComplexJoinExtraNormalizer complexJoinNormalizer;

    @Inject
    public DruidNormalizer(TypingNullsDialectExtraNormalizer typingNullNormalizer,
                              SubQueryFromComplexJoinExtraNormalizer complexJoinNormalizer) {
        this.typingNullNormalizer = typingNullNormalizer;
        this.complexJoinNormalizer = complexJoinNormalizer;
    }

    @Override
    public IQTree transform(IQTree tree, VariableGenerator variableGenerator) {
        return complexJoinNormalizer.transform(
                typingNullNormalizer.transform(tree, variableGenerator),
                variableGenerator);
    }
}