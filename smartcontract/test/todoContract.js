const TodoContract = artifacts.require("TodoContract");

contract("TodoContract", () => {
    it("Testing smart contract", async () => {
        const todoContract = await TodoContract.deployed();
        await todoContract.createTask("A new task");
        const task = await todoContract.todos(0);
        assert.equal(task.index, 0);
        assert.equal(task.taskName, "A new task");
        assert.equal(task.isComplete, false);
    });
});