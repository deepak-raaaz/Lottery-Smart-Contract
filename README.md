
# 🎲 Lottery Smart Contract  

Welcome to the **Lottery Smart Contract** project! 🚀 This project is a decentralized lottery system built using **Solidity** and deployed on the **Sepolia Testnet**. It allows users to participate in a lottery with fixed participation fees and ensures a transparent and fair winner selection process.



## 📜 Description  

This smart contract enables:  
1. **Participation**: Users can join the lottery by sending a fixed fee of 10 wei.  
2. **Balance Viewing**: Only the manager can view the contract's balance.  
3. **Random Winner Selection**: Ensures a fair winner is picked using a pseudo-random number generator.  
4. **Winner Reward**: The selected winner receives the total balance accumulated in the contract.



## 🚀 Features  

- **Decentralized Lottery**: Ensures transparency and fairness.  
- **Secure Management**: Only the contract manager has access to administrative functionalities.  
- **Auto-Reset**: Resets players list after a winner is selected, ready for the next round.  
- **Low Participation Fees**: Affordable entry with just 10 wei.  



## 🔧 Technologies Used  

- **Solidity**: Smart contract programming.  
- **Ethereum Blockchain**: Powered by Sepolia Testnet.  
- **MetaMask**: Wallet integration for transaction signing and testing.  
- **Remix IDE**: Smart contract development and deployment.  



## 🚨 How It Works  

### 1. Deploy  
The contract is deployed by the **manager** (contract creator).  

### 2. Participate  
- Users join the lottery by sending **exactly 10 wei** to the contract.  
- All participants' addresses are stored securely.  

### 3. Winner Selection  
- Only the **manager** can select a winner after at least 3 players have joined.  
- A random index is calculated, and the winner receives the contract's balance.  



## 🧩 Contract Code  

```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Lottery {
    address public manager;
    address payable[] public players;
    address payable public winner;

    constructor() {
        manager = msg.sender;
    }

    function participate() public payable {
        require(msg.value == 10 wei, "Participation requires exactly 10 wei.");
        players.push(payable(msg.sender));
    }

    function getBalance() public view returns (uint) {
        require(msg.sender == manager, "Access denied: Only the manager can view the balance.");
        return address(this).balance;
    }

    function random() internal view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, players.length)));
    }

    function getWinner() public {
        require(msg.sender == manager, "Access denied: Only the manager can select the winner.");
        require(players.length >= 3, "Insufficient players: At least 3 players are required to draw a winner.");

        uint r = random();
        uint index = r % players.length;
        winner = players[index];
        winner.transfer(getBalance());
        players = new address payable ;
    }
}
```


## 📝 Setup Instructions  

1. **Clone the Repository**:  
   ```bash
   git clone https://github.com/your-username/Lottery-Smart-Contract.git
   ```
2. **Open in Remix**:  
   - Go to [Remix IDE](https://remix.ethereum.org/).  
   - Upload the `Lottery.sol` file to the **contracts** folder.  

3. **Compile the Contract**:  
   - Use the **0.8.2+ compiler version**.  

4. **Deploy on Sepolia Testnet**:  
   - Configure **MetaMask** for Sepolia.  
   - Deploy the contract from Remix using injected Web3.  

5. **Interact**:  
   - Use the deployed contract interface in Remix to call the functions.  



## 📊 Future Enhancements  

- Dynamic participation fees.  
- Enhanced random number generator for better security.  
- Integration with a frontend for improved usability.  



## 🎉 Acknowledgments  

Special thanks to **Code Eater** for providing excellent tutorials on Solidity and blockchain development. 🙌  



### 🌐 Connect  

- [LinkedIn Post](https://www.linkedin.com/posts/deepak-raaaz_blockchain-solidity-smartcontracts-activity-7266869624032362498-3CXK?utm_source=share&utm_medium=member_desktop)  
- **Contact**: deepakjamui26@gmail.com  

---
