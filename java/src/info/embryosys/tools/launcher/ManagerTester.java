/*
 * Embryo Systems
 *
 * $Id$
 *
 * Copyright 2009 Nicolas R. Dufour <nrdufour@gmail.com>
 * 
 * This source code is released under the BSD License.
 */
package info.embryosys.tools.launcher;

import info.embryosys.adt.manager.AdtManager;
import info.embryosys.adt.manager.Workspace;
import info.embryosys.adt.manager.impl.SimpleAdtManager;
import info.embryosys.adt.request.AdtRequest;
import info.embryosys.adt.request.RequestFactory;

/**
 * @author nrdufour
 * 
 */
public class ManagerTester {

	private AdtManager manager;

	/**
	 * 
	 */
	public ManagerTester() {
		this.manager = new SimpleAdtManager();
	}

	public void run() {
		this.manager.init();

		String[] testValues = { "create Bridge", "create River", "create Bridge[Washington]",
				"create Bridge.height", "create Bridge->cross->River", };

		for (String value : testValues) {
			AdtRequest request = RequestFactory.analyzeString(value);
			this.manager.processRequest(request);
		}

		Workspace workspace = this.manager.getWorkspace();
		workspace.getStorage().debugDump();

		AdtRequest request = RequestFactory.analyzeString("hibern Bridge[Washington]");
		this.manager.processRequest(request);
		
		request = RequestFactory.analyzeString("destroy Bridge.height");
		this.manager.processRequest(request);

		workspace.getStorage().debugDump();
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		ManagerTester tester = new ManagerTester();

		tester.run();
	}

}