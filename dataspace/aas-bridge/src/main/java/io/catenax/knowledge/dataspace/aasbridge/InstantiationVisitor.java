package io.catenax.knowledge.dataspace.aasbridge;

import de.fraunhofer.iosb.ilt.faaast.service.model.visitor.AssetAdministrationShellElementVisitor;
import de.fraunhofer.iosb.ilt.faaast.service.model.visitor.AssetAdministrationShellElementWalker;
import io.adminshell.aas.v3.dataformat.core.visitor.AssetAdministrationShellElementWalkerVisitor;
import io.adminshell.aas.v3.model.*;
import io.adminshell.aas.v3.model.impl.DefaultReference;

import java.util.ArrayList;

public class InstantiationVisitor extends AssetAdministrationShellElementWalker {
    @Override
    public void visit(SubmodelElement sme) {
        sme.setKind(ModelingKind.INSTANCE);
        super.visit(sme);
    }

    @Override
    public void visit(Submodel submodel) {
        submodel.setKind(ModelingKind.INSTANCE);
        super.visit(submodel);
    }



}
