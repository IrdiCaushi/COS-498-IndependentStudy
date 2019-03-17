pragma solidity 0.5.0;

// Creating the contract
contract Contest {

	// Creating a structure to model the contestant
	struct Contestant {
		uint id;
		string name;
		uint voteCount; 
	}

	// Use mapping to get or fetch the contestant details
	mapping(uint => Contestant) public contestants;

	// Mapping to save the list of users/accounts who already voted
	mapping(address => bool) public voters;

	// A public variable to keep track of contestant count
	uint public contestantsCount;

	event votedEvent (
		uint indexed _contestantId
		);


	constructor () public {
		addContestant("COS440 Computer Network");
		addContestant("COS221 Fundamental Data Structures");

	}

	// Add a function to add contestant
	function addContestant (string memory _name) private {
		contestantsCount ++;
		contestants[contestantsCount] = Contestant(contestantsCount, _name, 0);
	}

	function vote (uint _contestantId) public {
		// Restricting the person who already casted the vote
		require(!voters[msg.sender]);
		// Require that the vote is casted to a valid contestant
		require(_contestantId > 0 && _contestantId <= contestantsCount);


		// Increase the contestant vote count
		contestants[_contestantId].voteCount ++;
		// Set the voter's voted status to true
		voters[msg.sender] = true;

		// Trigger the event
		emit votedEvent(_contestantId);
	}
}