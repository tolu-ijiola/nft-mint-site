import { ethers, BigNumber } from "ethers";
import { toast } from "react-toast";
import ToluBabaNFT from '../utils/ToluBabaNFT.json';


const Home = (props) => {

    const mint = async () => {
        const CONTRACT_ADDRESS = "0xFe55B42ec3331f78E76f574792373f85C9944cF5";
      
        try {
          const { ethereum } = window;
      
          if (ethereum) {
            const provider = new ethers.providers.Web3Provider(ethereum);
            const signer = provider.getSigner();
            const contract = new ethers.Contract(CONTRACT_ADDRESS, ToluBabaNFT.abi, signer);
      
            toast("Please wait...")
            
            const response = await contract.mint(BigNumber.from(1), {
                value: ethers.utils.parseEther((0.001).toString()),
            })
            console.log(response);
            toast.success("Minting success...")
      
          } else {
            console.log("Ethereum object doesn't exist!");
          }
        } catch (error) {
          toast.error("Minting failed...")
          console.log(error);
        }
    }

    return(
        <div className="homepage">
            <h1>Lorem Ipsume minting nft website for free leo fdjdl bryo</h1>
            <br/>
            <p className="light">You are here to make this one do and mint your nft for free baba</p>
            <div className="mint-details">
                <div>
                    <p>Mint Price</p>
                    <h5>0.001</h5>
                </div>
                <div>
                    <p>Mint per user</p>
                    <h5>0</h5>
                </div>
                <div>
                    <p>Public sale</p>
                    <h5>0</h5>
                </div>
                {/* <div>
                    <p>Sold</p>
                    <h5>0 / 256</h5>
                </div> */}
            </div>
            {props.account === "" ? <button onClick={props.connectWallet}>Connect</button> : <button onClick={mint}>Mint</button>}
        </div>
    )
}

export default Home