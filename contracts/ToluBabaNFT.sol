// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

/* import 'openzeppelin/contracts/token/ERC721/ERC721.sol';
import 'openzeppelin/contracts/token/access/Ownable.sol'; */
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ToluBabaNFT is ERC721, Ownable {
    uint256 public mintPrice;
    uint256 public totalSupply;
    uint256 public maxSupply;
    uint256 public maxPerWallet;
    bool public isPublicMintEnabled;
    string internal baseTokenUri;
    address payable public withdrawWallet;
    mapping(address => uint256) public walletMints;

    constructor() ERC721("ToluNFT", "ULOT") {
        mintPrice = 0.001 ether;
        totalSupply = 0;
        maxSupply = 256;
        maxPerWallet = 2;
    }

    function setIsPublicMintEnabled(bool isPublicMintEnabled_)
        external
        onlyOwner
    {
        isPublicMintEnabled = isPublicMintEnabled_;
    }

    function setBaseTokenUri(string calldata baseTokenUri_) external onlyOwner {
        baseTokenUri = baseTokenUri_;
    }

    function tokenUri(uint256 tokenId_)
        public
        view
        returns (string memory)
    {
        require(_exists(tokenId_), "Token does not exist!!!");
        return (
            string(
                abi.encodePacked(
                    baseTokenUri,
                    Strings.toString(tokenId_),
                    ".json"
                )
            )
        );
    }

    function withdraw() external onlyOwner {
        (bool success, ) = withdrawWallet.call{value: address(this).balance}(
            ""
        );
        require(success, "withdraw failed");
    }

    function mint(uint256 quantity_) public payable {
        require(isPublicMintEnabled, "Minting is not yet enabled");
        require(totalSupply + quantity_ <= maxSupply, "Mint is sold out");
        require(
            walletMints[msg.sender] + quantity_ <= maxPerWallet,
            "Each wallet cannot mint more than 2"
        );

        for (uint256 i = 0; i < quantity_; i++) {
            uint256 newTokenId = totalSupply + 1;
            totalSupply++;
            _safeMint(msg.sender, newTokenId);
        }
    }

    string[] female = [
        "Janie",
        "Sally",
        "Reagan",
        "Kailey",
        "Jayleen",
        "Tiana",
        "Melany",
        "Shaylee",
        "Dayanara",
        "Cierra",
        "Averie",
        "Averie",
        "Dayanara",
        "Alina"
    ];
    string[] male = [
        "Jalyn",
        "Kristian",
        "Ezra",
        "Spencer",
        "Javon",
        "Everardo",
        "Ignacio"
    ];
    string[] both = [
        "Alessandro",
        "Lorraine",
        "Kalob",
        "Cruz",
        "Aspen",
        "Jeremy",
        "Marco",
        "Trae",
        "Darrin",
        "Jalin",
        "Monika",
        "Daveon"
    ];

    string baseSvg =
        "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    function pickRandomFirstWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId)))
        );
        rand = rand % male.length;
        return male[rand];
    }

    function pickRandomSecondWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId)))
        );
        rand = rand % female.length;
        return female[rand];
    }

    function pickRandomThirdWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId)))
        );
        rand = rand % both.length;
        return both[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    /* function makeToluBabaNFT() public {
        uint256 newItemId = _tokenIds.current();

        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        string memory third = pickRandomThirdWord(newItemId);

        string memory finalSvg = string(
            abi.encodePacked(baseSvg, first, second, third, "</text></svg>")
        );

        _safeMint(msg.sender, newItemId);

        _setTokenURI(newItemId, "blah");

        _tokenIds.increment();
    } */
}
