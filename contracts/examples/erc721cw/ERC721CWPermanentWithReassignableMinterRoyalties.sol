// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "../../erc721c/presets/ERC721CWPermanent.sol";
import "../../programmable-royalties/MinterRoyaltiesReassignableRightsNFT.sol";

contract ERC721CWPermanentWithReassignableMinterRoyalties is ERC721CWPermanent, MinterRoyaltiesReassignableRightsNFT {

    constructor(
        uint256 royaltyFeeNumerator_,
        address royaltyRightsNFTReference_,
        address wrappedCollectionAddress_,
        string memory name_,
        string memory symbol_) 
        ERC721CW(wrappedCollectionAddress_, name_, symbol_) 
        MinterRoyaltiesReassignableRightsNFT(royaltyFeeNumerator_, royaltyRightsNFTReference_) {
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721C, MinterRoyaltiesReassignableRightsNFT) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function mint(address to, uint256 tokenId) external {
        _mint(to, tokenId);
    }

    function safeMint(address to, uint256 tokenId) external {
        _safeMint(to, tokenId);
    }

    function _mint(address to, uint256 tokenId) internal virtual override {
        _onMinted(to, tokenId);
        super._mint(to, tokenId);
    }

    function _burn(uint256 tokenId) internal virtual override {
        super._burn(tokenId);
        _onBurned(tokenId);
    }
}
