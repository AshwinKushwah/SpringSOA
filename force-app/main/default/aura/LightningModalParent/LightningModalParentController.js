({
	openModal : function(component, event, helper) {
		// We are finding the child component on markup and executing its aura method and passing the parameters to it.
		component.find('showModal').showChildModal(true);
	}
})