package ece.ntua.softeng.api;

import ece.ntua.softeng.conf.Configuration;
import ece.ntua.softeng.data.DataAccess;
import ece.ntua.softeng.data.model.Fields;
import ece.ntua.softeng.data.model.Frontisthrio;

import ece.ntua.softeng.data.model.Package;
import ece.ntua.softeng.data.model.User;
import org.restlet.data.Form;
import org.restlet.data.Status;
import org.restlet.representation.Representation;
import org.restlet.resource.ResourceException;
import org.restlet.resource.ServerResource;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public class FrontisthrioResource extends ServerResource {

    private final DataAccess dataAccess = Configuration.getInstance().getDataAccess();

    private final User user = Configuration.getInstance().getUser();

    @Override
    protected Representation get() throws ResourceException {

        String idAttr = getAttribute("fr_id");

        if (idAttr == null) {
            throw new ResourceException(Status.CLIENT_ERROR_BAD_REQUEST, "Missing frontisthrio id");
        }

        Long id = null;
        try {
            id = Long.parseLong(idAttr);
        }
        catch(Exception e) {
            throw new ResourceException(Status.CLIENT_ERROR_BAD_REQUEST, "Invalid frontisthrio id: " + idAttr);
        }

        Optional<Frontisthrio> fr_optional = dataAccess.getFrontisthrio(id);
        Frontisthrio fr = fr_optional.orElseThrow(() -> new ResourceException(Status.CLIENT_ERROR_NOT_FOUND, "Frontisthrio not found - id: " + idAttr));
        Optional<List> pkg_optional = dataAccess.getFrontisthrioPackages(id);
        List<Package> pkgs = pkg_optional.orElseThrow(() -> new ResourceException(Status.CLIENT_ERROR_NOT_FOUND, "A single package with id " +
                idAttr +" wasn't found"));
        Map<String, Object> fr_pkgs_map = new HashMap<>();
        fr_pkgs_map.put("frontisthrio", fr);
        fr_pkgs_map.put("packages", pkgs);
        return new JsonFrontisthrioPackagesRepresentation(fr_pkgs_map);
    }

    @Override
    protected Representation post(Representation entity) throws ResourceException {

        if (user.getPrivilege() < 1) throw new ResourceException(Status.CLIENT_ERROR_BAD_REQUEST, "You do not have access");

        String idAttr = getAttribute("fr_id");

        if (idAttr == null) {
            throw new ResourceException(Status.CLIENT_ERROR_BAD_REQUEST, "Missing frontisthrio id");
        }

        Long fr_id;
        try {
            fr_id = Long.parseLong(idAttr);
            System.out.println(fr_id);
        }
        catch(Exception e) {
            throw new ResourceException(Status.CLIENT_ERROR_BAD_REQUEST, "Invalid frontisthrio id: " + idAttr);
        }

        if (!dataAccess.checkOwnership(user.getId(), fr_id))
            throw new ResourceException(Status.CLIENT_ERROR_BAD_REQUEST, "Frontisthrio with id " + user.getId() + " doesn't have access to manipulate the id: " + (fr_id+1));


        Form form = new Form(entity);

        Fields field = Fields.valueOf(form.getFirstValue("field"));
        short price = Short.valueOf(form.getFirstValue("price"));
        int success_rate = Integer.valueOf(form.getFirstValue("success_rate"));
        String city = form.getFirstValue("city");
        String street = form.getFirstValue("street");
        int street_number = Integer.valueOf(form.getFirstValue("street_number"));

        Package pkg = dataAccess.addPackage(0, field, price, success_rate, city, street, street_number, fr_id);

        return new JsonPackageRepresentation(pkg);

    }

    @Override
    protected Representation delete() throws ResourceException {

        if (user.getPrivilege() < 1) throw new ResourceException(Status.CLIENT_ERROR_BAD_REQUEST, "You do not have access");

        String idAttr = getAttribute("fr_id");

        if (idAttr == null) {
            throw new ResourceException(Status.CLIENT_ERROR_BAD_REQUEST, "Missing frontisthrio id");
        }

        Long fr_id = null;
        try {
            fr_id = Long.parseLong(idAttr);
        }
        catch(Exception e) {
            throw new ResourceException(Status.CLIENT_ERROR_BAD_REQUEST, "Invalid frontisthrio id: " + idAttr);
        }

        if (!dataAccess.checkOwnership(user.getId(), fr_id))
            throw new ResourceException(Status.CLIENT_ERROR_BAD_REQUEST, "Frontisthrio with id " + user.getId() + " doesn't have access to manipulate the id: " + (fr_id+1));

        dataAccess.deleteFrontisthrio(fr_id);
        return null;
//        throw new ResourceException(Status.SERVER_ERROR_NOT_IMPLEMENTED);
    }
}
