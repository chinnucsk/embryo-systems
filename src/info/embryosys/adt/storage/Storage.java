/*
 * Embryo Systems
 *
 * $Id$
 *
 * Copyright 2009 Nicolas R. Dufour <nrdufour@gmail.com>
 */
package info.embryosys.adt.storage;

import info.embryosys.adt.core.Adt;
import info.embryosys.adt.core.AdtId;

/**
 * @author nrdufour
 * 
 */
public interface Storage {

	Adt load(AdtId id);

	void store(Adt adt);

	void clean(AdtId id);
}