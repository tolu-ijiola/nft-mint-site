import { useEffect, useState } from 'react';
import { toast, ToastContainer } from 'react-toast';
import './App.css';
import Header from './component/header';
import Home from './component/home';

function App() {

  const [account, setaccount] = useState("")

  const checkIfWalletIsConnected = async () => {

    const { ethereum } = window;

    if (!ethereum) {
      return toast("Check if you have Metamask installed");
    }
    const accounts = await ethereum.request({ method: 'eth_accounts' });
    if (accounts.length !== 0) {
      const account = accounts[0];
      setaccount(account);
    } else {
      setaccount("")
    }
  }

  const connectWallet = async () => {
    try {
      const { ethereum } = window;

      if (!ethereum) {
        toast("Metamask is not installed");
        return;
      }

      const accounts = await ethereum.request({ method: "eth_requestAccounts" });

      toast.success(`Connected to ${accounts[0]}`);
      setaccount(accounts[0]); 
    } catch (error) {
      console.log(error);
      toast.error("An error occurred")
    }
}

const checkNetwork = async () => {
  const { ethereum } = window;

  let chainId = await ethereum.request({ method: 'eth_chainId' });
const rinkebyChainId = "0x4"; 
if (chainId !== rinkebyChainId) {
	toast.error("You are not connected to the Rinkeby Test Network!");
}
}

  useEffect(() => {
    checkIfWalletIsConnected();
    checkNetwork();
  }, [])

  return (
    <div>
      <Header account={account} connectWallet={connectWallet}/>
      <Home account={account} connectWallet={connectWallet}/>
      <ToastContainer delay={5000}/>
    </div>
  );
}

export default App;
